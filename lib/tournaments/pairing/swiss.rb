module Tournaments::Pairing
  class Swiss
    class UnmatchableRound < StandardError; end

    def self.pair tournament, players, options = {}
      round = Tournaments::Round.new(tournament)

      proposed_matches = []
      players.each_slice(2) { |pair| proposed_matches << pair }
      better_matches = fix_invalid_matches(proposed_matches)
      round.matches = better_matches.map { |players| Tournaments::Match.new(tournament, *players) }

      round
    end

    def self.fix_invalid_matches matches
      bucketed = self.bucket_by_score matches
      buckets = bucketed.keys.sort.reverse

      buckets.each_with_index do |score, index|
        while invalid_match = self.find_invalid_match(bucketed[score]) do
          up_a_bucket = ( index + 1 < buckets.size ) ? buckets[index + 1] : buckets[index]
          down_a_bucket = buckets[index - 1]
          unless  self.swap_into_group(invalid_match, bucketed[score]) ||
                  self.swap_into_group(invalid_match, bucketed[up_a_bucket]) ||
                  self.swap_into_group(invalid_match, bucketed[down_a_bucket])
            raise UnmatchableRound
          end
        end
      end

      bucketed.values.flatten(1)
    end

    def self.find_invalid_match matches
      matches.find { |match| played?(match[0], match[1]) }
    end

    def self.bucket_by_score matches
      matches.group_by { |(player_1, player_2)| player_1.match_points }
    end

    def self.swap_into_group match, bucket
      bucket.each do |candidate|
        return true if self.swap_if_possible(match, candidate)
      end

      false
    end

    def self.swap_if_possible match, other_match
      return false if match == other_match

      if !played?(match[0], other_match[0]) && !played?(match[1], other_match[1])
        match[1], other_match[0] = other_match[0], match[1]
        true
      elsif !played?(match[0], other_match[1]) && !played?(match[1], other_match[0])
        match[1], other_match[1] = other_match[1], match[1]
        true
      else
        false
      end
    end

    def self.played? player_1, player_2
      player_1 && player_2 && player_1.previous_opponents.include?(player_2)
    end
  end
end