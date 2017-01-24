# Awk

An implementation of the basic operations of the awk language written in ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'awk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install awk

## Usage

create a new instance to evaluate a file
`awk = Awk::Awk.new('path/file_name.txt')`

create a new instance to evaluate a string
`awk = Awk::Awk.new('some string')`

an evaluation instance consists of a pattern and an action
`awk.pattern { |col| col[1] > 3 }.action { |col| puts "#{col[2]} is great!" }`

an evaluation instance is executed with `.perform`
```
awk.pattern { |p| p[1] > 3 }.action { |p| puts "#{p[2]} is great!" }
 .pattern { |p| p[1] < 3 }.action { |p| puts "#{p[2]} is too bad!" }
 .perform
```

common keywords are avialable on the proc scope for pattern and action
`begin`, `end`, `nr`, and `nf`
```
awk.pattern { |p| p.end }.action { |p| puts "this happens at the end of the evaluation" }
awk.pattern { |p| p.begin }.action { |p| puts "this happens at the beginning of the evaluation" }
awk.pattern { |p| true }.action { |p| puts "#{p.nr} lines read so far" }
awk.pattern { |p| true }.action { |p| puts "#{p.nf} fields in this row" }
```

an action method given without a pattern method will assume the pattern is true
`awk.action { |p| puts "this will be printed for every row" }`

but a pattern given without a cooresponding action will be ignored
`awk.pattern { |p| p[1] > 2 }.pattern { |p| p[1] < 2 }.action { |p| "#{p[1]} is less than 2" }`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DanielNill/awk.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

