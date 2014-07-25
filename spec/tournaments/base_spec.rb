require 'spec_helper'

module Tournaments
  describe Base do
    let(:player_one) { Tournaments::Player.new('Spike') }
    let(:player_two) { Tournaments::Player.new('Jenny') }
    let(:player_three) { Tournaments::Player.new('Timmy') }
    let(:player_four) { Tournaments::Player.new('Rita') }
    let(:tournament) { Tournaments::Base.new [player_two, player_one, player_three, player_four] }

    describe "initialization" do
      it "expects a list of players, which it wraps in a PlayerList" do
        expect(tournament.players).to be_a_kind_of(PlayerList)
      end
    end

    describe "#current_round" do
      it "returns nil if there are no rounds" do
        expect( tournament.current_round ).to be_nil
      end

      it "returns the last round if there are rounds" do
        tournament.rounds << Round.new(tournament)

        expect( tournament.current_round ).to be_a_kind_of(Round)
      end
    end

    describe "#generate_round" do
      it "generates a new round with matches" do
        tournament.generate_round(random: Random.new(3))
        round = tournament.current_round
        expect(round.matches.map(&:players)).to eq([
          [player_four, player_one],
          [player_two, player_three]
        ])
      end

      it "finalizes the previous round" do
        tournament.generate_round
        first_round = tournament.current_round
        expect(first_round).not_to be_finished

        tournament.generate_round(random: Random.new(3))
        expect(first_round).to be_finished
      end
    end

  end
end