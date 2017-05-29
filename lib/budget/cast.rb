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
        rescue Cast::Error
          false
        end
      end
    end

    def self.define_record_cast(name)
      define_cast(name) do |value|
        record_class = Budget.const_get(name)

        case value
        when record_class then value
        when Integer, /^\d+$/
          record_class[value.to_i] ||
            raise(Cast::RecordNotFound, "unable to cast #{value.inspect} to #{name}.  Record does not exist.")
        else raise Cast::Error, "unable to cast #{value.inspect} to #{name}"
        end
      end
    end
  end
end
