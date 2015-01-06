module BlackjackRb
  class Player
    # a player has a hand and they can take some actions

    attr_reader :hand
    attr_accessor :money, :bet

    # initially, a player is created with only a hand
    def initialize
      @bet = 10
      @money = 100
      @hand = BlackjackRb::Hand.new
    end

    # receives a card and adds it to the hand
    def receive(card)
      @hand.add_to_hand(card)
    end

    # resets the hand
    def reset
      @hand = BlackjackRb::Hand.new
    end

    # lets the player bet. the player cannot go under the minimum or over their money
    def collect_bet
      SHELL.warn("Minimum bet is $#{10}. You have $#{@money}.")
      @bet = SHELL.ask("How much do you want to bet? Enter a number between #{MINIMUM} and #{@money}.").range(MINIMUM..@money).read_int
    end

  end
end
