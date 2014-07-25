require 'spec_helper'

module Tournaments
  describe PlayerList do
    let(:player_list) { PlayerList.new }

    it "has an internal array attribute called list" do
      expect(player_list.list).to be_a_kind_of(Array)
    end

    it "sorts that list on creation" do
      player_1 = Player.new('Spike')
      player_2 = Player.new('Jenny')
      allow(player_1).to receive(:match_points).and_return(2)
      allow(player_2).to receive(:match_points).and_return(4)

      player_list = PlayerList.new([player_1, player_2])
      expect( player_list.list.map(&:name) ).to eq ['Jenny', 'Spike']
    end

    describe "delegation" do
      it "delegates length to the @list" do
        player_list.list = ['player_1', 'player_2']
        expect(player_list.length).to eq(2)
      end
    end

    describe "#shuffle" do
      it "randomizes the list" do
        player_1 = Player.new('Spike')
        player_2 = Player.new('Jenny')

        player_list = PlayerList.new([player_1, player_2])

        expect( player_list.list.map(&:name) ).to eq ['Spike', 'Jenny']
        player_list.shuffle(random: Random.new(3)) # shuffle with predictable RNG seed
        expect( player_list.list.map(&:name) ).to eq(['Jenny', 'Spike'])
      end
    end
  end
end