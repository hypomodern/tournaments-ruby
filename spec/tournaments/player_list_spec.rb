require 'spec_helper'

module Tournaments
  describe PlayerList do
    let(:player_list) { PlayerList.new }
    let(:player_one) { Player.new('Spike') }
    let(:player_two) { Player.new('Jenny') }

    it "has an internal array attribute called list" do
      expect(player_list.list).to be_a_kind_of(Array)
    end

    it "sorts that list on creation" do
      allow(player_one).to receive(:match_points).and_return(2)
      allow(player_two).to receive(:match_points).and_return(4)

      player_list = PlayerList.new([player_one, player_two])
      expect( player_list.list.map(&:name) ).to eq ['Jenny', 'Spike']
    end

    describe "delegation" do
      it "delegates length to the @list" do
        player_list = PlayerList.new([player_one, player_two])
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

    describe "#update_rankings" do
      it "re-sorts the list" do
        player_three = Player.new('Johnny')
        player_list = PlayerList.new([player_one, player_two, player_three])
        expect( player_list.list.map(&:name) ).to eq ['Spike', 'Jenny', 'Johnny']

        allow(player_one).to receive(:match_points).and_return(2)
        allow(player_two).to receive(:match_points).and_return(6)
        allow(player_three).to receive(:match_points).and_return(4)

        player_list.update_rankings
        expect( player_list.list.map(&:name) ).to eq ['Jenny', 'Johnny', 'Spike']
      end
    end
  end
end