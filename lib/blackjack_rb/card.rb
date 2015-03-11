module BlackjackRb
  class Card
    # each card maintains its suit and rank
    attr_reader :rank, :suit

    # create a new card object
    def initialize(rank, suit)
      @rank, @suit = rank, suit
    end

    # stringifies a card
    def to_s
      "#{rank_to_s} #{suit_to_s}"
    end

    # properly returns the ranks of the cards
    # assumes we count an ace as 1 always.
    # 11, 12, 13 ranks are Jack, Queen, and King cards
    # respectively, so their rank is 10.
    def rank
      @rank > 10 ? 10 : @rank
    end

    private
    def rank_to_s
      if rank.eql?(1)
        "A"
      elsif rank.eql?(11)
        "J"
      elsif rank.eql?(12)
        "Q"
      elsif rank.eql?(13)
        "K"
      else
        rank
      end
    end

    def suit_to_s
      case suit
      when :club
        "\xE2\x99\xA3"
      when :diamond
        "\xE2\x99\xA6"
      when :spade
        "\xE2\x99\xA0"
      when :heart
        "\xE2\x99\xA5"
      end
    end
  end
end
