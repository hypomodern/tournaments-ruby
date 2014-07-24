# Tournaments

The goal is to create a gem where I can choose a type of tournament (e.g. `tourney = Tournaments::Swiss.new`) and hand it a list of player objects (perhaps `tourney.next_round(players)`? and have it return pairings for the next round. It can probably just wrap BraketTree for the elimination trees. Open questions:

1. how to handle swiss/group stage to knockout round transitions?
2. How much state does / should it keep?
3. BracketTree yay or nay? How much wrapping is too much?

## Installation

Add this line to your application's Gemfile:

    gem 'tournaments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tournaments

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tournaments-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
