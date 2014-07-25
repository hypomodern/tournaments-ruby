require 'forwardable'

module Tournaments
  class PlayerList
    extend Forwardable
    def_delegators :@list, :<<, :length, :each # and anything else
    attr_accessor :list

    def initialize list = []
      @list = list.sort
    end

    def shuffle **args
      @list.shuffle! **args
    end

    def update_rankings
      @list = list.sort
    end

    def inspect
      "#<Tournaments::PlayerList @list=[" +
        @list.map {|p| "#{p.name} points: #{p.match_points}, SoS: #{p.strength_of_schedule}"}.join(", ") +
        "]>"
    end
  end
end