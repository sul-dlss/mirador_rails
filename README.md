# MiradorRails [![Gem Version](https://badge.fury.io/rb/mirador_rails.svg)](https://badge.fury.io/rb/mirador_rails)

⚠️ `mirador_rails` is a Ruby gem for including Mirador 2 in Rails app. Please note that Mirador 2 is no longer under active development.

We recommend using Mirador 3 via the [mirador npm package](https://www.npmjs.com/package/mirador). Recommended approaches to embedding Mirador 3 are available on the [Mirador wiki](https://github.com/projectmirador/mirador/wiki).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mirador_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mirador_rails

### Mount the Engine
In your `routes.rb` file mount the MiradorRails::Engine
```ruby
mount MiradorRails::Engine, at: MiradorRails::Engine.locales_mount_path
```

## Usage

You can require the mirador js by requiring the following:

```javascript
//= require mirador
```

And the css 

```css
/*
 *= require mirador
 */
```

You may not want to do this in your application.js, as the JavaScript by itself may add over 1.8MB to your application.js payload.

### Initialize mirador in a view

```erb
<%= mirador_tag() %>
```

The `mirador_tag` method takes several arguments which allow for customization of the mirador view.

```ruby
# @param [String] id
# @param [String] height
# @param [String] width
# @param [String] position
# @param [String] display
# @param [Hash] options Mirador settings
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Upgrading

From a new Mirador release build, run the rake task with the tag:

```sh
$ bundle exec rake update[v2.1.4]
```

Delete FontAwesome and MaterialIcons from mirador-combined.css. We include this in dependent gems instead.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sul-dlss/mirador_rails.


## License

The gem is available as open source under the terms of the Apache 2.0.
