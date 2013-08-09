# Rack::Lacquer

This middleware parses the entire response body, so its not very fast, but it is very effective. This is a great way to simulate Varnish or another ESI layer in development mode.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-lacquer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-lacquer

## Usage

In your rails environment file, add the following:

``` ruby
config.middleware.insert_before ActionDispatch::Static, Rack::Lacquer
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
