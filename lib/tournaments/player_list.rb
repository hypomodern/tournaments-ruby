require 'forwardable'

module Tournaments
  class PlayerList
    extend Forwardable
    def_delegators :@list, :<<, :length # and anything else
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
  end
end