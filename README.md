# Tournaments

The goal is to create a gem where I can choose a type of tournament (e.g. `tourney = Tournaments::Swiss.new`) and hand it a list of player objects (perhaps `tourney.add_players(players)`? and have it return pairings for the next round. It can probably just wrap BraketTree for the elimination trees. Open questions:

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

Sample script (assuming `bundle exec irb -rtournaments`):

```ruby
player_one = Tournaments::Player.new("Sally")
player_two = Tournaments::Player.new("Jane")
player_three = Tournaments::Player.new("Bob")
player_four = Tournaments::Player.new("Randy")
player_five = Tournaments::Player.new("R2D2")
player_six = Tournaments::Player.new("The Wookiee")

tourney = Tournaments::Swiss.new([player_one, player_two, player_three, player_four, player_five, player_six], game_win_points: 2)
tourney.generate_round

tourney.current_round.matches.each do |match|
  puts match.players.map(&:name).join(" vs ")
  match.report_results do |m|
    m.add_game winner:m.players.first, loser:m.players.last
  end
end

tourney.current_round.finalize_round

tourney.players

player_three.previous_opponents.map(&:name)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tournaments-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
