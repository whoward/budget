# frozen_string_literal: true

module Budget
  module Cast
    Error = Class.new(ArgumentError)

    def self.define_cast(name, &block)
      define_singleton_method(name, &block)

      define_singleton_method("#{name}?") do |value|
        begin
          block.call(value)
          true
        rescue Casts::Error
          false
        end
      end
    end
  end
end
