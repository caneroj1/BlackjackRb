module BlackjackRb
  class Deck
    # a deck will have 52 cards and it will have certain actions
    # that it can do, such as give a card, or shuffle

    attr_reader :cards

    # this will initialize the deck by calling another method to create the cards
    # in order to have a nice, proper deck, and then we shuffle the cards
    def initialize
      @cards = create_cards
      shuffle_cards
    end

    # draw card method. this will pop a card off the top of the deck and return it
    def draw_card
      @cards.pop
    end

    ## PRIVATE METHODS
    private

    # this method will instantiate 4 groups of 13 cards.
    # the groups will be created by suit
    def create_cards
      # create clubs
      clubs = Array.new(13) { |rank| BlackjackRb::Card.new(rank + 1, :club) }

      # create diamonds
      diamonds = Array.new(13) { |rank| BlackjackRb::Card.new(rank + 1, :diamond) }

      # create spades
      spades = Array.new(13) { |rank| BlackjackRb::Card.new(rank + 1, :spade) }

      # create hearts
      hearts = Array.new(13) { |rank| BlackjackRb::Card.new(rank + 1, :heart) }

      # join them all together
      (clubs + diamonds + spades + hearts)
    end

    # shuffle the cards via the following algorithm: start at the last card and generate a random index
    # between the beginning and the index of the current card and swap the current card with the card
    # at the generated index. decrement pointer.
    def shuffle_cards
      51.downto(0) do |current|
        random_index = rand(current + 1)
        swap(current, random_index)
      end
    end

    # classic 3 line swape. classic.
    def swap(a, b)
      tmp = @cards[a]
      @cards[a] = @cards[b]
      @cards[b] = tmp
    end
  end
end
