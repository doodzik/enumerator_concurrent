# enumerator_concurrent

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enumerator_concurrent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enumerator-concurrent

## Usage

```ruby
  # Enumerator::Concurrent inherits from Array
  require 'enumerator_concurrent'

  # every iteration is run in an own thread
  [1,2,3,4].concurrent.each { |x| x*2 }
  # => [2,4,6,8]

  # specify how many threads should deal with the Enumerable.
  queued = [1,2,3,4].concurrent.threads(2)

  # doesn't preserve the structure
  queued.each { |x| x*2 }
  # => [1,2,3,4]

  # preserves the structure
  queued.map { |x| x*2 }
  # => [2,4,6,8]

```

## Contributing

1. Fork it ( https://github.com/doodzik/enumerator-concurrent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


The MIT License (MIT)

Copyright (c) 2014 Frederik Dudzik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
