module BlackjackRb
  class Hand

    # a hand has some cards
    # and a hand also has a value, which is the current sum of the cards.
    # value will be an array that can store many different hand values, depending on if we have an ace,
    # since an array can be a 1 or 11.
    attr_accessor :cards, :values

    # initially, we create a blank array with no cards
    # and the value array is an array of one zero.
    def initialize
      @cards = []
      @values = [0]
    end

    # this will push a card onto the hand
    # it will update the value array appropriately.
    # if the card is an ace, we must add a value to the value array.
    # @value[0] is the value where all aces are ones.
    # @value[i] where i is > 0 represents the value where the ith ace is 11.
    def add_to_hand(card)
      # add the new card to each "hand"
      @values = @values.map { |val| val + card.rank }

      # change accordngly if there is an ace
      update_for_ace if card.rank.eql?(1)

      @cards.push(card)
    end

    # check if the hand busted
    # a player busts if they are over 21 in each of the value array's values
    def busted?
      busted = true
      @values.each { |val| val > 21 ? busted &= true : busted &= false }
      busted
    end

    # check if the hand is blackjack
    # blackjack is when one of the values in the value array is 21
    def blackjack?
      blackjack = false
      @values.each { |val| blackjack |= val.eql?(21) }
      blackjack
    end

    # for the dealer. check if any hand is under 17
    def under_17?
      under = false
      @values.each { |val| under |= val < 17 }
      under
    end

    # for the dealer. check if there is a value that is greater than 21 and under 17
    # if there is, the dealer should not hit
    def should_hit?
      hit = true
      @values.each { |val| hit &= !(val >= 17 && val <= 21) }
      hit
    end

    # returns the highest value in the hand under 21
    def highest_value
      @values.inject { |highest, val| highest = (val < 21 && val > highest) ? val : highest }
    end

    private
    def update_for_ace
      # since the value at @value[0] counts all aces as 1s,
      # whenever we add a new @value[i], we need to just add 10 to @value[0]
      @values.push(@values[0] + 10)
    end
  end
end
