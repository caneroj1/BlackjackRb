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
      SHELL.confirm("Let's play some blackjack!")
      loop do
        collect_bets
        give_initial_cards
        # ask if player would like to split here
        @players.each { |player| action_cycle(player, :player) }
        action_cycle(@dealer, :dealer)
        decide_scores
        break if done_playing?
        reset
      end
    end

    def collect_bets
      @players.each { |player| player.collect_bet }
    end

    def action_cycle(player, who)
      response = nil
      loop do
        if who.eql?(:player)
          RENDERER.render(@dealer.hand.cards, :dealer)
          RENDERER.render(player.hand.cards, who)

          SHELL.confirm("Would you like to hit or stay or double?")
          SHELL.ask("Enter 's' to stay, 'h' to hit, or 'd' to double.")

          response = get_input

          double_player(player) if response.eql?('d')
          hit_player(player) if (response.eql?('h') || response.eql?('d'))
        else
          if @dealer.hand.under_17? && @dealer.hand.should_hit?
            SHELL.confirm("Dealer's turn")
            RENDERER.render(player.hand.cards, :end)
            SHELL.warn("Press any key to continue")
            gets
            hit_player(@dealer)
          else
            response = "s"
          end
        end
        break if (player.hand.busted? || player.hand.blackjack? || response.eql?("s"))
      end
    end

    def decide_scores
      RENDERER.render(@dealer.hand.cards, :end)

      # if the dealer busts, any hand that doesn't bust wins
      dealer_busted = @dealer.hand.busted?(false) ? true : false

      # any player that doesn't have a blackjack loses
      dealer_blackjack = @dealer.hand.blackjack?(false) ? true : false

      # dealer's highest value hand that doesn't bust
      dealer_high = @dealer.hand.highest_value

      @players.each do |player|
        if player.hand.busted?(false)
          SHELL.error("You lost $#{player.bet}")
          player.money -= player.bet
        elsif player.hand.blackjack?(false) && !dealer_blackjack
          SHELL.confirm("You won $#{player.bet * 1.5}!")
          player.money += (player.bet * 1.5)
        elsif player.hand.blackjack?(false) && dealer_blackjack
          SHELL.confirm("Push!")
        elsif !player.hand.blackjack?(false) && dealer_blackjack
          SHELL.error("You lost $#{player.bet}")
          player.money -= player.bet
        elsif !player.hand.busted?(false) && dealer_busted
          SHELL.confirm("You won $#{player.bet}!")
          player.money += (player.bet)
        elsif !player.hand.busted?(false) && !dealer_busted
          if player.hand.highest_value > dealer_high
            SHELL.confirm("You won $#{player.bet}!")
            player.money += (player.bet)
          elsif player.hand.highest_value < dealer_high
            SHELL.error("You lost $#{player.bet}")
            player.money -= player.bet
          else
            SHELL.confirm("Push!")
          end
        end
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

    # goes through the 'hit' process with the current player
    def hit_player(player)
      new_card = @deck.draw_card
      RENDERER.render_card(new_card)
      player.receive(new_card)
    end

    # doubles the player's bet
    def double_player(player)
      player.bet *= 2
    end

    # reset the players' and dealer's hands
    def reset
      @players.each { |player| player.reset }
      @dealer.reset
      system "clear"
    end

    # get answer from the user
    def get_input
      begin
        inp = gets.chomp
        raise Error unless %w{s h d}.include?(inp)
      rescue
        retry
      end
      inp
    end
  end
end
