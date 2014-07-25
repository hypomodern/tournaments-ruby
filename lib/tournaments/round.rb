require 'forwardable'

module Tournaments
  class Round
    extend Forwardable
    def_delegators :@matches, :<<, :length, :size, :each, :map
    attr_accessor :matches, :tournament, :finished

    def initialize tournament, matches = []
      @tournament   = tournament
      @matches      = matches
      @finished     = false
    end

    def finished?
      !!finished
    end

    def complete?
      @matches.all? { |match| match.finished? }
    end

    def finalize_round
      self.finished = true
      tournament.players.update_rankings
    end
  end
end