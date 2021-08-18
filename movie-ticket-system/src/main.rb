class Main

  def main

    Movie.new(
      "Avartar",
      "2 시간",
      Money.wons(10000),
      AmountDiscountPolicy.new(
        [
          PeriodCondition.new("목요일", 2, 8),
          PeriodCondition.new("화요일", 2, 8),
          SequenceCondition.new(1),
          SequenceCondition.new(10)
        ],
        Money.wons(800)
      )
    )

  end

end