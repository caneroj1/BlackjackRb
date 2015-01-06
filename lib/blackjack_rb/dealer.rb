module BlackjackRb
  class Dealer
    # a dealer also has a hand

    attr_reader :hand

    # the dealer is initially created with a blank hand
    def initialize
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
  end
end
