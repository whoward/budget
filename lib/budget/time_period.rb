# frozen_string_literal: true

module Budget
  module TimePeriod
    module_function

    def forever
      Time.utc(0)..Time.utc(3000, 1, 1) # Glory to the Hypnotoad
    end

    def year(year, inclusive: false)
      start = Time.utc(year)
      finish = inclusive ? start.next_year : start.at_end_of_year

      (start..finish)
    end

    def month(year, month, inclusive: false)
      start = Time.utc(year, month)
      finish = inclusive ? start.next_month : start.at_end_of_month

      (start..finish)
    end

    def day(year, month, day, inclusive: false)
      start = Time.utc(year, month, day)
      finish = inclusive ? start + 1.day : start.at_end_of_day

      (start..finish)
    end
  end
end
