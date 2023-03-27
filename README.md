# Rubocop::Solidus

Automatic Solidus code style checking tool.
A RuboCop extension focused on enforcing Solidus best practices and coding conventions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-solidus', require: false
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubocop-solidus

## Usage

To Start using this extension in your application add the following lines to your `.rubocop.yml` file

```yaml
require:
    - rubocop-solidus
```

After this simply use the `rubocop` command to start linting.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piyushswain/rubocop-solidus.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
