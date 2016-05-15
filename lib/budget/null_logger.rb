
# frozen_string_literal: true
module Budget
  module NullLogger
    %i(debug info warn error critical).each do |level|
      define_singleton_method(level) { |*_args, &_block| }
    end
  end
end
