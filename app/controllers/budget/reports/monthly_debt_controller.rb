require 'budget/month_enumerator'
require 'csv'

module Budget
  module Reports
    class MonthlyDebtController < ApplicationController
      def show
        respond_to do |format|
          format.html
          format.csv { render text: to_csv }
        end
      end

      private

      def to_csv
        CSV.generate do |csv|
          csv << %w(year month day value)
          months.each { |row| csv << row }
        end
      end

      def months
        MonthEnumerator.since_first_transaction.map do |year, month|
          time = Time.zone.local(year, month, 1, 0, 0, 0)

          net_diff = MonthlyDebtReport.new(time).net_income / 100.0

          [year, month, 1, net_diff]
        end
      end
    end
  end
end
