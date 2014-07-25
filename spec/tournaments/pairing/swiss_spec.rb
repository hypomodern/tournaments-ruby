require 'spec_helper'

module Tournaments::Pairing
  describe Swiss do
    let(:player_one) { Tournaments::Player.new('Spike') }
    let(:player_two) { Tournaments::Player.new('Jenny') }
    let(:player_three) { Tournaments::Player.new('Timmy') }
    let(:player_four) { Tournaments::Player.new('Rita') }
    let(:tournament) { Tournaments::Swiss.new [player_one, player_two, player_three, player_four] }

    context "with players that all have 0 points" do
      it 'takes a list of players and generates in-order matches' do
        round = Swiss.pair(tournament, tournament.players)
        expect(round.matches.map(&:players)).to eq([
          [player_one, player_two],
          [player_three, player_four]
        ])
      end
    end

    context 'once players have some points' do
      context 'a clean, neat distribution' do
        it "pairs according to point standings" do
          allow(player_one).to receive(:match_points).and_return(6)
          allow(player_two).to receive(:match_points).and_return(0)
          allow(player_three).to receive(:match_points).and_return(4)
          allow(player_four).to receive(:match_points).and_return(2)
          tournament.players.update_rankings

          round = Swiss.pair(tournament, tournament.players)
          expect(round.matches.map(&:players)).to eq([
            [player_one, player_three],
            [player_four, player_two]
          ])
        end
      end

      context 'when players have played each other before' do
        it "swaps pairs out to arrive at the best available solution" do
          allow(player_one).to receive(:match_points).and_return(6)
          allow(player_two).to receive(:match_points).and_return(4)
          allow(player_three).to receive(:match_points).and_return(2)
          allow(player_four).to receive(:match_points).and_return(0)
          player_two.previous_opponents = [player_one]
          player_one.previous_opponents = [player_two]
          tournament.players.update_rankings

          round = Swiss.pair(tournament, tournament.players)
          expect(round.matches.map(&:players)).to eq([
            [player_one, player_three],
            [player_two, player_four]
          ])
        end

        it "raises an error if it cannot fix the problem" do
          allow(player_one).to receive(:match_points).and_return(6)
          allow(player_two).to receive(:match_points).and_return(4)
          allow(player_three).to receive(:match_points).and_return(2)
          allow(player_four).to receive(:match_points).and_return(0)
          player_one.previous_opponents = [player_two, player_three, player_four]
          tournament.players.update_rankings

          expect { Swiss.pair(tournament, tournament.players) }.to raise_error(Tournaments::Pairing::Swiss::UnmatchableRound)
        end
      end
    end

  end
end