module BlackjackRb
  class Player
    # a player has a hand and they can take some actions

    attr_reader :hand, :money, :bet

    # initially, a player is created with only a hand
    def initialize
      @hand = BlackjackRb::Hand.new
    end

    # receives a card and adds it to the hand
    def receive(card)
      @hand.add_to_hand(card)
    end
  end
end
