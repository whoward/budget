
# frozen_string_literal: true
module Budget
  module Reports
    class MonthlyBudgetController < BaseController
      def show
        @report = Report::MonthlyBudget.new(time)
      end

      private

      YearMonth = Struct.new(:year, :month) do
        def value
          "#{year}-#{month}"
        end

        def text
          Time.zone.local(year, month, 1, 0, 0, 0).strftime('%B %Y')
        end
      end

      def selected_year
        params.fetch(:year, Time.now.year).to_i
      end
      helper_method :selected_year

      def selected_month
        params.fetch(:month, Time.now.month).to_i
      end
      helper_method :selected_month

      def time
        Time.zone.local(selected_year, selected_month, 1, 0, 0, 0)
      end
      helper_method :time

      def selectable_periods
        MonthEnumerator.since_first_transaction.map { |y, m| YearMonth.new(y, m) }.reverse
      end
      helper_method :selectable_periods
    end
  end
end
