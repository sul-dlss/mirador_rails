# MiradorRails

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mirador_rails`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mirador_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mirador_rails

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Upgrading

From a new Mirador release build, copy the following:

locales

```sh
$ cp -r ~/Downloads/build/mirador/locales vendor/assets/
```

images

```sh
$ cp -r ~/Downloads/build/mirador/images/ vendor/assets/
```

stylesheet

```sh
$ cp ~/Downloads/build/mirador/css/mirador-combined.css vendor/assets/stylesheets/
```

javascript

```sh
$ cp ~/Downloads/build/mirador/mirador.min.js vendor/assets/javascripts/
$ cp ~/Downloads/build/mirador/mirador.min.js.map vendor/assets/javascripts/
```

tinymce plugins

```sh
$ cp -r ~/Downloads/build/mirador/plugins vendor/assets/plugins/
```

tinymce themes

```sh
$ cp -r ~/Downloads/build/mirador/themes vendor/assets/themes/
```

 Delete FontAwesome and MaterialIcons from mirador-combined.css. We include this in dependent gems instead.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sul-dlss/mirador_rails.


## License

The gem is available as open source under the terms of the Apache 2.0.
