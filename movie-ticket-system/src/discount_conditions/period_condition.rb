class PeriodCondition
  include DiscountCondition

  def initialize(day_of_week, start_time, end_time)
    @day_of_week = day_of_week
    @start_time = start_time
    @end_time = end_time
  end

  def is_satisfied?(screening)
    screening.when_screened == @day_of_week and @start_time < screening.start_time and @end_time > screening.start_time
  end

end