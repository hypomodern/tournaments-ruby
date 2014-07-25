require 'tournaments/version'
require 'tournaments/base'

module Tournaments
  autoload :Player, 'tournaments/player'
  autoload :PlayerList, 'tournaments/player_list'
  autoload :Round, 'tournaments/round'
  autoload :Match, 'tournaments/match'
  autoload :Game, 'tournaments/game'
  autoload :Swiss, 'tournaments/swiss'

  # pairing systems
  module Pairing
    autoload :Randomized, 'tournaments/pairing/randomized'
    autoload :Swiss, 'tournaments/pairing/swiss'
  end
end
