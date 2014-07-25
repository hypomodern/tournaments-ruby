module Tournaments
  class Game
    attr_accessor :raw_data, :tournament, :match, :winner, :loser, :winner_side, :loser_side

    def initialize data
      self.raw_data     = data
      self.tournament   = data.fetch(:tournament)
      self.match        = data.fetch(:match)
      self.winner       = data.fetch(:winner)
      self.loser        = data.fetch(:loser)
      self.winner_side  = data.fetch(:winner_side, 'n/a')
      self.loser_side   = data.fetch(:loser_side, 'n/a')
    end

    def points_for player
      if player_is_winner? player
        self.tournament.points_for_game_win
      elsif player_is_loser? player
        self.tournament.points_for_game_loss
      else
        0
      end
    end

    def player_is_winner? player
      self.winner == player
    end

    def player_is_loser? player
      self.loser == player
    end

    def inspect
      "#<Tournaments::Game @winner=#{winner.name} @loser=#{loser.name}>"
    end
  end
end