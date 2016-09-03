# frozen_string_literal: true

require 'logger'

module Budget
  module Logger
    module_function

    def default
      Rails.logger
    end

    def null
      NullLogger
    end

    def console
      @stdout ||= ::Logger.new($stdout).tap do |log|
        log.level = ::Logger::DEBUG
        log.formatter = -> (sev, _, _, msg) { "[#{sev}] #{msg}\n" }
      end
    end
  end

  module NullLogger
    %i(debug info warn error critical unknown).each do |level|
      define_singleton_method(level) { |*_args, &_block| }
    end
  end
end
