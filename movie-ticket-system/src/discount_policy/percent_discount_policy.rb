class PercentDiscountPolicy < DiscountPolicy

  def initialize(conditions, percent)
    super(conditions)
    @percent = percent
  end

  def get_discount_amount(screening)
    screening.get_movie_fee.times(@percent)
  end

end