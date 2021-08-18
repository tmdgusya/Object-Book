class AmountDiscountPolicy < DiscountPolicy

  def initialize(conditions, discount_amount)
    super(conditions)
    @discount_amount = discount_amount
  end

  def get_discount_amount(screening)
    @discount_amount4
  end

end