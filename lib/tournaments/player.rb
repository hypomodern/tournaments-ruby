module Tournaments
  class Player
    attr_accessor :name, :matches, :previous_opponents, :data

    include Comparable

    def initialize name, data = {}, matches = [], previous_opponents = []
      self.name                 = name
      self.data                 = data
      self.matches              = matches
      self.previous_opponents   = previous_opponents
    end

    def games
      self.matches.inject([]) { |games, match| games += match.games; games }
    end

    def match_points
      self.matches.inject(0) { |points, match| points += match.points_for(self); points }
    end

    def strength_of_schedule
      self.previous_opponents.inject(0) { |points, opponent| points += opponent.match_points; points }
    end

    def <=> other
      [other.match_points, other.strength_of_schedule] <=> [self.match_points, self.strength_of_schedule]
    end

    # This is to sort out some PORO comparator wankery
    def id
      @id ||= data.fetch(:id, SecureRandom.uuid)
    end

    def == other
      if id
        id == other.id
      elsif
        name == other.name
      else
        self === other
      end
    end

  end
end