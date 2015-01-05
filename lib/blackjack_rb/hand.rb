module BlackjackRb
  class Hand

    # a hand has some cards
    # and a hand also has a value, which is the current sum of the cards
    attr_accessor :cards, :value

    # initially, we create a blank array with no cards
    def initialize
      @cards = []
      @value = 0
    end

    # this will push a card onto the hand
    def add_to_hand(card)
      @value += card.rank
      @cards.push(card)
    end

    # check if the hand busted
    # a player busts if they are over 21
    def busted?
      @value > 21 && SHELL.error("You busted! :(")
    end

    # check if the hand is blackjack
    # blackjack is when the value is 21
    def blackjack?
      @value.eql?(21) && SHELL.confirm("Blackjack! :)")
    end
  end
end
