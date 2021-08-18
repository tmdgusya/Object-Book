class Money

  module UNIT
    ZERO = Money.wons(0)
  end

  private def initialize(amount)
    @amount = amount
  end

  public def self.wons(amount)
    Money.new(amount)
  end

  public def plus(amount)
    Money.new(@amount + amount)
  end

  public def minus(amount)
    Money.new(@amount - amount)
  end

  public def times(percent)
    Money.new(@amount * percent)
  end

  public def is_less_then?(amount)
    @amount < amount
  end

  public def is_greater_then?(amount)
    @amount > amount
  end

end