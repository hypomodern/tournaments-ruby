module Tournaments
  class Base
    attr_accessor :players, :rules

    def initialize players, rules = {}
      self.players = PlayerList.new(players)
      self.rules = rules
    end

    def points_for_game_win
      self.rules.fetch(:game_win_points, 1)
    end

    def points_for_game_loss
      self.rules.fetch(:game_loss_points, 0)
    end

    def points_for_match_win
      self.rules.fetch(:match_win_points, 0)
    end
  end
end