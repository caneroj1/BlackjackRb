module BlackjackRb
  class Renderer
    def render(cards, who)
      case who
      when :player
        render_player(cards, who)
      when :dealer
        render_dealer(cards, who)
      when :end
        render_player(cards, who)
      end
    end

    def render_card(card)
      table = TTY::Table.new [[card.to_s]]
      display_card(table)
    end

    private
    def render_player(cards, who)
      table = TTY::Table.new [make_cards_array(cards)]
      display(table, who, cards.count)
    end

    def render_dealer(cards, who)
      table = TTY::Table.new [[cards[0].to_s, "? ?"]]
      display(table, who, cards.count)
    end

    def make_cards_array(cards)
      card_array = []
      cards.each { |card| card_array.push(card.to_s) }
      card_array
    end

    def display(table, who, cards)
      SHELL.confirm(who.eql?(:player) ? "Your cards" : "Dealer's Cards")
      SHELL.warn(
        table.render(:ascii, multiline: true, width: 10 * cards, resize: true) { |renderer| renderer.padding= [1, 1, 1, 2] } )
    end

    def display_card(table)
      SHELL.confirm("New Card")
      SHELL.warn(
        table.render(:ascii, multiline: true, width: 10, resize: true) { |renderer| renderer.padding= [1, 1, 1, 2] } )
    end
  end
end
