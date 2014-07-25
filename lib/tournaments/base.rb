module Tournaments
  class Base
    attr_accessor :players, :rules, :rounds

    def initialize players, rules = {}
      self.players  = PlayerList.new(players)
      self.rules    = rules
      self.rounds   = []
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

    def pairing_system
      self.rules.fetch(:pairing_system, Pairing::Randomized)
    end

    def current_round
      rounds.last
    end

    def generate_round options = {}
      current_round.finalize_round if current_round
      rounds << pairing_system.pair(self, players, options)
    end

    def inspect
      "#<Tournaments::Base @list=#{players.inspect} @rounds=[#{rounds.map(&:inspect).join(',')}]>"
    end
  end
end