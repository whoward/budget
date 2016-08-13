# frozen_string_literal: true

module Budget
  module Calculator
    class DaysInPeriod
      def initialize(period)
        @period = period
      end

      def result
        (period.first.to_date - period.last.to_date).to_i.abs
      end

      private

      attr_reader :period
    end
  end
end
