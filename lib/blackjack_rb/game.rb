module BlackjackRb
  class Game
    # the game class will exist as a container for the players, the dealer, and their cards
    # and will handle all game actions.

    # the game will have an instance (or multiple) of Deck that will give out all the cards

    # the game will have a Dealer that will play the role of (...any guesses?) the dealer
    # and will simulate giving the players cards.

    # the game will have players, and the game will ask what their action will be for their turn

    attr_reader :deck, :dealer, :players

    # initialize the game object, accepts params for the number of players
    def initialize(number_of_players)
      @deck = BlackjackRb::Deck.new
      @dealer = BlackjackRb::Dealer.new
      @players = Array.new(number_of_players) { BlackjackRb::Player.new }
    end

    # play the game of blackjack. go through each player
    # and put them into the 'action cycle'!!! WHOA
    # after the players are done, go do the dealer actions.
    # when the dealer has finished playing, go through a score round
    def play
      give_initial_cards

      loop do
        # GET BETS FROM PLAYERS HERE
        @players.each { |player| action_cycle(player, :player) }
        # action_cycle(@dealer, :dealer)
        # decide_scores
        break if done_playing?
      end
    end

    def action_cycle(person, who)
      response = nil
      loop do
        if who.eql?(:player)
          puts "YOUR CARDS \n#{person.hand.cards.inspect}"
          puts "DEALER'S CARD \n#{@dealer.hand.cards[0].inspect}"
          # RENDER PLAYER CARDS HERE
          # RENDER DEALER CARDS
          SHELL.confirm("Would you like to hit or stay or double?")
          response = SHELL.ask("Enter 's' to stay, 'h' to hit, or 'd' to double.").argument(:required).on_error(:retry).valid(['s', 'h', 'd']).read_char
          person.receive(@deck.draw_card) if response.eql?('h')
          # ask if player would like to split here
        end
        break if (person.hand.busted? || person.hand.blackjack? || response.eql?("s"))
      end
    end

    # asks the user if they want to continue to play the game
    def done_playing?
      response = true
      SHELL.confirm("Keep Playing Blackjack?")
      begin
        response = SHELL.ask("Enter 'Yes' or 'No'").read_bool
      rescue Exception => e
        SHELL.error("Exiting due to error: #{e}")
        response = true
      ensure
        return !response
      end
    end

    # set up the players and the dealer with their initial cards
    def give_initial_cards
      # deal each player their initial cards
      @players.each do |player|
        player.receive(@deck.draw_card)
        player.receive(@deck.draw_card)
      end

      # give the dealer his two cards
      @dealer.receive(@deck.draw_card)
      @dealer.receive(@deck.draw_card)
    end
  end
end
