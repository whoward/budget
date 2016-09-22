# frozen_string_literal: true
require 'singleton'

module Budget
  module Preferable
    def self.included(base)
      base.extend(ClassMethods)
    end

    def preference_column
      :preferences
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
          if values.key?(preference_column)
            self[preference_column]
          else
            default.call
          end
        end

        define_method "preferred_#{name}=" do |value|
          preference_store[name] = value
        end
      end
    end
  end
end
