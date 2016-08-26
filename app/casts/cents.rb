# frozen_string_literal: true

module Budget
  module Cast
    # Converts the given value into a fixnum representing the correct number of cents
    define_cast(:Cents) do |value|
      case value

      when Integer then value

      when Float then (value * 100).round

      when DOLLARS_AND_CENTS_STRING then value.tr('.', '').to_i

      when NUMBER_STRING then value.to_i

      else raise Cast::Error, "Cannot cast #{value.class} to cents"

      end
    end

    DOLLARS_AND_CENTS = /^\d+\.\d{2}$/

    NUMBER = /^\d+$/

    DOLLARS_AND_CENTS_STRING = -> (v) { v.is_a?(String) && v.match(DOLLARS_AND_CENTS) }

    NUMBER_STRING = -> (v) { v.is_a?(String) && v.match(NUMBER) }
  end
end
