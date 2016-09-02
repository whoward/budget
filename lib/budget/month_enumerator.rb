
# frozen_string_literal: true
module Budget
  class MonthEnumerator
    include Enumerable

    attr_reader :start, :final

    def self.since_first_transaction
      date = TransactionRecord.min(:date) || Time.zone.today
      new(date.year, date.month)
    end

    def initialize(start_year, start_month, end_year: nil, end_month: nil)
      @start = Date.new(start_year, start_month)

      # the final date will be the beginning of the current month unless specified
      @final =
        if end_year && end_month
          Date.new(end_year, end_month)
        else
          Time.zone.today.at_beginning_of_month
        end

      # this class is immutable
      freeze
    end

    def each
      return to_enum(:each) unless block_given?

      current = start.dup

      loop do
        break if current > final

        yield current.year, current.month

        current = current.next_month
      end
    end
  end
end
