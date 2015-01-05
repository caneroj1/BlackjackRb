module BlackjackRb
  require_relative './blackjack_rb/player.rb'
  require_relative './blackjack_rb/hand.rb'
  require_relative './blackjack_rb/deck.rb'
  require_relative './blackjack_rb/card.rb'
  require_relative './blackjack_rb/dealer.rb'
  require_relative './blackjack_rb/game.rb'
  require 'tty'

  # the shell will be for interacting with the users via the console
  SHELL = TTY::Shell.new

  class << self
    def start
      BlackjackRb::Game.new(1).play
    end
  end
end
