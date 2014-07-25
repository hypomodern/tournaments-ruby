module Tournaments
  module Pairing
    class Randomized

      def self.pair tournament, players, options = {}
        shuffled_list = players.dup.shuffle(random: options[:random])
        round = Tournaments::Round.new(tournament)

        shuffled_list.each_slice(2) do |players|
          match = Tournaments::Match.new(tournament, *players)
          round.matches << match
        end
        round
      end

    end
  end
end