# FFlags

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fflags'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fflags

## Usage

```ruby
require 'socket'

FFlags.config do |config|
  config.key   = Socket.gethostname
  config.flags = { new_view: true }
end
```

Then in the code,

```ruby
# Verify if the flag is enabled
FFlags.enabled?(:new_view)

# Overwrite flag
FFlags.toggle(:new_view)
# or
FFlags.set_flag(:new_view, false)

# To reset, and get back to the default settings.
FFlags.reset
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rspec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/faizalzakaria/fflags.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
