require_relative 'domain/movie'
require_relative 'domain/money'
require_relative 'domain/screening'
require_relative 'domain/reservation'
require_relative 'discount_policy/amount_discount_policy'
require_relative 'discount_policy/percent_discount_policy'
require_relative 'discount_conditions/discount_condition'
require_relative 'discount_conditions/period_condition'
require_relative 'discount_conditions/sequence_condition'

class Main

    avartar = Movie.new(
      "Avartar",
      "2 시간",
      Money.wons(10000),
      PercentDiscountPolicy.new(
        [
          PeriodCondition.new("목요일", 2, 8),
          PeriodCondition.new("화요일", 2, 8),
          SequenceCondition.new(1),
          SequenceCondition.new(10)
        ],
        10
      )
    )

    avartar2 = Movie.new(
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

    puts avartar.calculate_money_fee(Screening.new(avartar, 1, "목요일", 5)).amount == 9000
    puts avartar2.calculate_money_fee(Screening.new(avartar, 1, "목요일", 5)).amount == 9200

end