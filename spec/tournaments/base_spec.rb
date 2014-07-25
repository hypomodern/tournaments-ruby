require 'spec_helper'

module Tournaments
  describe Base do

    describe "initialization" do
      it "expects a list of players, which it wraps in a PlayerList" do
        tourney = Base.new(['player_1', 'player_2'])
        expect(tourney.players).to be_a_kind_of(PlayerList)
      end
    end

  end
end