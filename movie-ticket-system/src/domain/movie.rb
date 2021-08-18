class Movie
  attr_reader :title, :running_time, :fee, :discount_policy

  def initialize(title, running_time, fee, discount_policy)
    @title = title
    @running_time = running_time
    @fee = fee
    @discount_policy = discount_policy
  end

  public def calculate_money_fee(screening)
    fee.minus(@discount_policy.calculate_discount_amount(screening))
  end

end