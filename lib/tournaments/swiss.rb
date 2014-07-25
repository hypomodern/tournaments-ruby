module Tournaments
  class Swiss < Base
    def pairing_system
      Tournaments::Pairing::Swiss
    end
  end
end