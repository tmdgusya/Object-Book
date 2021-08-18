class DiscountPolicy

  def initialize(conditions)
    @conditions = conditions
  end

  public def calculate_discount_amount(screening)
    @conditions.each do |discount_policy|
      if discount_policy.is_satisfied?(screening)
        return get_discount_amount(screening)
      end
    end

    return Money::UNIT::ZERO
  end

  #interface
  def get_discount_amount(screening)
    raise RuntimeError("Plz implement that")
  end

end