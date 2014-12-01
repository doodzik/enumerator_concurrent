# Enumerator::Concurrent

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'Enumerator-Concurrent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Enumerator-Concurrent

## Usage

```ruby
  require 'enumerator/concurrent.rb'
  
  result = [1,2,3,4].concurrent.each { |x| x*2 }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/Enumerator-Concurrent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
