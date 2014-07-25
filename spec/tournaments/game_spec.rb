require 'spec_helper'

module Tournaments
  describe Game do
    let(:tournament) { Tournaments::Base.new [] }
    let(:player_one) { Player.new('Rachel') }
    let(:player_two) { Player.new('Gabriel') }
    let(:match) { Match.new(tournament, player_one, player_two) }
    let(:game) { Game.new(tournament: tournament, match: match, winner: player_one, loser: player_two) }


    describe "#points_for" do
      it "returns the tournament's configured value for a game win if the player is the winner" do
        allow(tournament).to receive(:points_for_game_win).and_return(10)
        expect( game.points_for(player_one) ).to eq(10)
      end

      it "returns the tournament's configured value for a game loss if the player is the loser" do
        allow(tournament).to receive(:points_for_game_loss).and_return(-1)
        expect( game.points_for(player_two) ).to eq(-1)
      end

      it "returns 0 otherwise" do
        expect( game.points_for(Player.new("Bill")) ).to eq(0)
      end
    end

  end
end