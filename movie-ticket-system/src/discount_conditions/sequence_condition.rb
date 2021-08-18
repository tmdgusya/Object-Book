class SequenceCondition
  include DiscountCondition

  def initialize(sequence)
    @sequence = sequence
  end

  def is_satisfied?(screening)
    screening.is_sequence?(@sequence)
  end

end