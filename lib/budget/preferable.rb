require 'singleton'

module Budget
  module Preferable
    extend ActiveSupport::Concern

    included do
      has_many :preferences, dependent: :destroy, as: :owner
    end

    def preference_store
      @store ||= ActiveRecordStore.new(self)
    end

    def defined_preferences
      methods.grep(/\Apreferred_[^=]*\Z/)
    end

    module ClassMethods
      def preference(name, default: nil)
        default_value = default
        default = -> { default_value } unless default.is_a?(Proc)

        # cache_key will be nil for new objects, then if we check if there
        # is a pending preference before going to default
        define_method "preferred_#{name}" do
          preference_store.fetch(name, &default)
        end

        define_method "preferred_#{name}=" do |value|
          preference_store[name] = value
        end
      end
    end

    ActiveRecordStore = Struct.new(:record) do
      def fetch(preference, &default)
        existing = existing(preference)

        if existing
          existing.value
        else
          self[preference] = default.call
        end
      end

      def []=(preference, value)
        existing = existing(preference)

        if existing.nil?
          record.preferences.build(key: preference.to_s, value: value)
        else
          existing.value = value
        end

        value
      end

      private

      def existing(preference)
        record.preferences.detect { |p| p.key == preference.to_s }
      end
    end
  end
end
