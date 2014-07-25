require 'spec_helper'

module Tournaments
  describe Player do
    let(:player) { Player.new("Herbert") }

    describe "comparable" do
      context "comparison vs player with no matches played" do
        it "returns 0" do
          rival = Player.new("Spike")
          expect(player <=> rival).to eq(0)
        end
      end

      context "comparison vs. player with more match_points" do
        it "returns 1" do
          rival = Player.new("Spike")
          allow(rival).to receive(:match_points).and_return(10)
          expect(player <=> rival).to eq(1)
        end

        it "returns 1 even if we have more SoS" do
          rival = Player.new("Spike")
          allow(rival).to receive(:match_points).and_return(10)
          allow(player).to receive(:strength_of_schedule).and_return(15)
          expect(player.strength_of_schedule > rival.strength_of_schedule).to be true
          expect(player <=> rival).to eq(1)
        end
      end

      context "comparison vs. player with fewer match_points" do
        it "returns -1" do
          rival = Player.new("Johnny")
          allow(player).to receive(:match_points).and_return(10)
          expect(player <=> rival).to eq(-1)
        end

        it "returns -1 even if they have more SoS" do
          rival = Player.new("Johnny")
          allow(player).to receive(:match_points).and_return(10)
          allow(rival).to receive(:strength_of_schedule).and_return(15)
          expect(player.strength_of_schedule < rival.strength_of_schedule).to be true
          expect(player <=> rival).to eq(-1)
        end
      end

      context "comparison vs. player with the same match_points" do
        it "returns 0" do
          rival = Player.new("Johnny")
          allow(player).to receive(:match_points).and_return(10)
          allow(rival).to receive(:match_points).and_return(10)
          expect(player <=> rival).to eq(0)
        end

        it "returns -1 if we have more SoS" do
          rival = Player.new("Johnny")
          allow(player).to receive(:strength_of_schedule).and_return(15)
          expect(player.strength_of_schedule > rival.strength_of_schedule).to be true
          expect(player <=> rival).to eq(-1)
        end

        it "returns 1 if they have more SoS" do
          rival = Player.new("Johnny")
          allow(rival).to receive(:strength_of_schedule).and_return(15)
          expect(player.strength_of_schedule < rival.strength_of_schedule).to be true
          expect(player <=> rival).to eq(1)
        end
      end
    end

    describe "#id" do
      it "returns a uuid in the absence of a data hash containing an ID" do
        expect(player.id).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
      end

      it "returns the id attribute from the data hash" do
        player.data = { id: '123abc' }
        expect(player.id).to eq('123abc')
      end
    end

    describe "#match_points" do
      it "returns 0 when the player has no previous matches" do
        expect( player.match_points ).to eq(0)
      end

      context 'with previous matches' do
        let(:rival) { Player.new("Suzie Q.") }
        let(:chump) { Player.new("Johnny") }

        it "returns the sum of the points earned in those matches" do
          tournament = Tournaments::Base.new([player, rival, chump], game_win_points: 2)
          match_one = Match.new(tournament, player, rival)
          match_one.report_results do |m|
            m.add_game winner: player, loser: rival
            m.add_game winner: rival, loser: player
          end

          match_two = Match.new(tournament, player, chump)
          match_two.report_results do |m|
            m.add_game winner: player, loser: chump
            m.add_game winner: player, loser: chump
          end

          expect(player.match_points).to eq(6)
        end

      end
    end

    describe "#strength_of_schedule" do
      it "returns 0 when the player has no previous opponents" do
        expect( player.strength_of_schedule ).to eq(0)
      end

      context 'with previous opponents' do
        let(:rival) { Player.new("Suzie Q.") }
        let(:chump) { Player.new("Johnny") }

        it "returns the sum of the points earned by those players" do
          allow(rival).to receive(:match_points).and_return(16)
          allow(chump).to receive(:match_points).and_return(4)
          player.previous_opponents = [ rival, chump ]

          expect(player.strength_of_schedule).to eq(20)
        end

      end
    end

  end
end