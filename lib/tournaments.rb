require 'tournaments/version'
require 'tournaments/base'

module Tournaments
  autoload :Player, 'tournaments/player'
  autoload :PlayerList, 'tournaments/player_list'
  autoload :Match, 'tournaments/match'
  autoload :Game, 'tournaments/game'
  autoload :Swiss, 'tournaments/swiss'
end
