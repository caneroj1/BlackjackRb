module BlackjackRb
  class Card
    # each card maintains its suit and rank
    attr_reader :rank, :suit

    # create a new card object
    def initialize(rank, suit)
      @rank, @suit = rank, suit
    end
  end
end
