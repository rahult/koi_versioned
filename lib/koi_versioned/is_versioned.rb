module KoiVersioned
  module IsVersioned
    extend ActiveSupport::Concern

    class NoDraftFoundException < Exception; end

    included do
    end

    module ClassMethods
      def is_versioned
        before_save :set_version_state
        serialize :version_draft, Hash
      end
    end

    def ignore_columns
      ["id", "version_state", "version_draft", "created_at", "updated_at"]
    end

    def set_version_state
      self.version_state = false if version_state.nil?
      # Returning true explicitly to make callback chain work
      true
    end

    def draft
      return nil if !is_draft?

      version_draft.each do |k, v|
        begin
          send :write_attribute, k.to_sym , v
        rescue NoMethodError
          logger.warn "Attribute #{k} does not exist on #{self.class} (id: #{id})."
        end
      end

      self
    end

    def is_published?
      !!version_state
    end

    def is_draft?
      is_published? ? !version_draft.blank? : true
    end

    def publish!
      self.attributes = version_draft if is_draft?
      self.version_state = true
      self.version_draft = nil
      save
    end

    def draft!
      # Only proceed if record has changed and already has a published version
      return true if !changed? && !is_published?

      # Store all attributes temporarily skipping read only attributes
      draft = attributes.reject { |key, value| ignore_columns.include? key }

      # Realod attributes from the database to clear all dirty attributes
      reload

      # Save draft in version_draft
      self.version_draft = draft

      # Temporarily disable time stamp updates as we do not want to record draft updated_at time
      self.class.record_timestamps = false
      begin
        # Saves the record
        save
      ensure
        # Re-enable time stamp updates
        self.class.record_timestamps = true
      end
    end
  end
end

ActiveRecord::Base.send :include, KoiVersioned::IsVersioned
