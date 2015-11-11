
module Budget
  class MonthEnumerator
    include Enumerable

    def self.since_first_transaction
      date = Transaction.minimum(:date) || Time.zone.now
      new(date.year, date.month)
    end

    def initialize(start_year, start_month, end_year: nil, end_month: nil)
      @year = start_year
      @month = start_month

      if end_year && end_month
        @final = Time.zone.local(end_year, end_month, 1, 0, 0, 0)
      else
        @final = Time.zone.now.at_beginning_of_month
      end
    end

    def each
      return to_enum(:each) unless block_given?

      loop do
        start = Time.zone.local(@year, @month, 1, 0, 0, 0)

        break if start > @final

        yield @year, @month

        @year = start.next_month.year
        @month = start.next_month.month
      end
    end
  end
end
