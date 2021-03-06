class Screening
  attr_reader :movie, :sequence, :when_screened, :start_time

  def initialize(movie, sequence, when_screened, start_time)
    @movie = movie
    @sequence = sequence
    @when_screened = when_screened
    @start_time = start_time
  end

  public def reserve(customer, audience_count)
    Reservation.new(customer, self, calculate_fee(audience_count), audience_count)
  end

  public def get_start_time
    @when_screened
  end

  public def is_sequence?(sequence)
    @sequence == sequence
  end

  public def get_movie_fee
    @movie.fee
  end

  #input type int
  private def calculate_fee(audience_count)
    @movie.calculate_movie_fee(self).times(audience_count)
  end

end