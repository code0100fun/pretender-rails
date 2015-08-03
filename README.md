# Pretender Rails

Stub clientside calls to external services.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pretender-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pretender-rails

## Usage

### Cucumber

```ruby
# features/support/env.rb
require 'pretender/rails/cucumber'

# features/step_definitions/pretender.rb
Given(/^there is a "(.*?)" endpoint$/) do |url|
  @stub = stub("get", url, [200, {}, ""])
end

Given(/^that endpoint returns "(.*?)"$/) do |response|
  @stub.response = [200, {}, response]
end
```

### In development

```ruby
Pretender.server.stub('get', 'https://api.github.com/repos/code0100fun/pretender-rails', [200, {}, {name: "mock-repo"}.to_json])
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pretender-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
