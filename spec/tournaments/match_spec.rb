require 'spec_helper'

module Tournaments
  describe Match do
    let(:player_one) { Player.new('Rachel') }
    let(:player_two) { Player.new('Gabriel') }
    let(:tournament) { Tournaments::Base.new [player_two, player_one] }
    let(:match) { Match.new(tournament, player_one, player_two) }


    describe "#finished?" do
      it "returns false if the match isn't marked as finished yet" do
        expect(match).not_to be_finished
      end

      it "returns true if the match is marked as finished" do
        match.finished = true
        expect(match).to be_finished
      end
    end

    describe "#finalize_match!" do
      it "sets the match as finished" do
        match.finalize_match!
        expect(match).to be_finished
      end

      it "adds the match to the player's list of matches" do
        match.finalize_match!

        expect( player_one.matches ).to include(match)
        expect( player_two.matches ).to include(match)
      end

      it "adds each opponent to the player's list of opponents" do
        match.finalize_match!

        expect( player_one.previous_opponents ).to include(player_two)
        expect( player_two.previous_opponents ).to include(player_one)
      end

    end

    describe "#add_game" do
      it "adds the given game to the internal array" do
        match.add_game winner: match.players.first, loser: match.players.last
        expect( match.games.length ).to eq(1)
      end
    end

    describe "#report_results" do
      it "yields self to the block" do
        expect { |b| match.report_results(&b) }.to yield_with_args(match)
      end

      it "flags the match as finished" do
        match.report_results { |m| }
        expect(match).to be_finished
      end
    end

    describe "#points_for" do
      context "with some games played" do
        it "returns the sum of the points earned by that player in the games" do
          match.report_results do |m|
            m.add_game winner: player_one, loser: player_two
            m.add_game winner: player_one, loser: player_two
          end

          expect( match.points_for(player_one) ).to eq(2 * tournament.points_for_game_win)
          expect( match.points_for(player_two) ).to eq(2 * tournament.points_for_game_loss)
        end
      end

      context "with no games played" do
        it "returns 0" do
          match.players.each do |player|
            expect( match.points_for(player) ).to eq(0)
          end
        end
      end
    end
  end
end