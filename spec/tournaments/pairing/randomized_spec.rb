require 'spec_helper'

module Tournaments::Pairing
  describe Randomized do
    let(:player_one) { Tournaments::Player.new('Spike') }
    let(:player_two) { Tournaments::Player.new('Jenny') }
    let(:player_three) { Tournaments::Player.new('Timmy') }
    let(:player_four) { Tournaments::Player.new('Rita') }
    let(:tournament) { Tournaments::Base.new [player_two, player_one, player_three, player_four] }

    it 'takes a list of players and generates randomized matches' do
      round = Randomized.pair(tournament, tournament.players, random: Random.new(3))
      expect(round.matches.map(&:players)).to eq([
        [player_four, player_one],
        [player_two, player_three]
      ])
    end

  end
end