module KoiVersioned
  module IsVersioned
    extend ActiveSupport::Concern

    class NoDraftFoundException < Exception; end

    module ClassMethods
      def is_versioned
        serialize :version_draft, Hash
        before_save :set_version_data
        scope :published, where("version_state = ?", true)
        scope :draft, where("version_state = ? OR (version_draft NOT LIKE ? AND version_state = ?)", false, '--- !!null%', true)
      end
    end

    def ignore_columns
      ["id", "version_state", "version_draft", "created_at", "updated_at"]
    end

    def set_version_data
      self.version_state ||= false
      self.version_draft = nil if version_draft.blank?

      # Explicitly return true to continue callback chain
      return true
    end

    def version
      @version ||= false
    end

    def version=(value=false)
      @version = value
    end

    def is_published?
      !!version_state
    end

    def is_draft?
      is_published? ? !version_draft.blank? : true
    end

    def publish!
      self.version = true
      save
    end

    def draft!
      self.version = false
      save
    end

    def save(*)
      version ? publish : draft

      begin
        super
      ensure
        self.class.record_timestamps = true
      end
    end

    def revert!
      return true unless is_published?
      self.version = true
      update_attributes(version_draft: nil)
    end

    def draft_version
      return nil unless is_draft?

      version_draft.each do |k, v|
        begin
          send :write_attribute, k.to_sym , v
        rescue NoMethodError
          logger.warn "Attribute #{k} does not exist on #{self.class} (id: #{id})."
        end
      end

      self
    end

  private

    def publish
      # Load draft version if draft is present?
      draft_version if is_draft?

      #FIXME: Change true to publish
      self.version_state = true
      self.version_draft = nil
    end

    def draft
      # Only proceed if record has changed or is not published
      return true if !changed? || !is_published?

      # Store all attributes temporarily skipping ignored columns
      draft_attributes = attributes.reject { |key, value| ignore_columns.include? key }

      # Reload attributes from the database to clear all dirty attributes
      # and deactivate timestamps before saving the record
      unless new_record?
        reload
        self.class.record_timestamps = false
      end

      # Save draft in version_draft
      self.version_draft = draft_attributes
    end
  end
end

ActiveRecord::Base.send :include, KoiVersioned::IsVersioned
