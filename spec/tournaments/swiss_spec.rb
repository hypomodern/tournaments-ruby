require 'spec_helper'

module Tournaments
  describe Swiss do
    describe "#pairing_system" do
      it "should be hardcoded to Swiss" do
        expect( Tournaments::Swiss.new([]).pairing_system ).to be(Tournaments::Pairing::Swiss)
      end
    end
  end
end