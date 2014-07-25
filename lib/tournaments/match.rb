module Tournaments
  class Match
    attr_accessor :tournament, :players, :games, :finished

    def initialize tournament, *players
      self.tournament = tournament
      self.players    = players
      self.games      = []
      self.finished   = false
    end

    # Intended use:
    #   match.report_results do |m|
    #     m.add_game winner: player_1, loser: player_2, winner_side: 'Name of Side', loser_side: 'Name of Side'
    #   end
    def report_results &block
      yield self
      self.finalize_match!
    end

    def finalize_match!
      self.finished = true
      players.each do |player|
        player.matches << self
        player.previous_opponents |= (players - [player])
      end
    end

    def add_game data = {}
      self.games << Game.new(
        tournament: self.tournament,
        match: self,
        winner: data[:winner],
        loser: data[:loser],
        winner_side: data[:winner_side],
        loser_side: data[:loser_side]
      )
    end

    def finished?
      !!finished
    end

    def points_for player
      points = self.games.inject(0) do |points, game|
        points += game.points_for player
        points
      end

      # points += tournament.points_for_match_win if player_is_match_winner? player
      points
    end

    # def player_is_match_winner? player
    #   games_won = games.count { |g| g.winner == player }
    #   games_won > games.length.to_f / 2
    # end

  end
end