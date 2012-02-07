module KoiVersioned
  module IsVersioned
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def is_versioned
        before_create :set_version_state
      end
    end

    def set_version_state
      self.version_state = false unless version_state
      true
    end

    def is_published?
      !!version_state
    end

    def is_draft?
      true
    end

    def publish!
      self.version_state = true
      self.version_draft = nil
      save
    end
  end
end

ActiveRecord::Base.send :include, KoiVersioned::IsVersioned
