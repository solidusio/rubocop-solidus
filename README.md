# Rubocop::Solidus

Automatic Solidus code style checking tool.
A RuboCop extension focused on enforcing Solidus best practices and coding conventions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-solidus', github: 'nebulab/rubocop-solidus', require: false
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

## Creating new cops

To create a new cop, run the following command:

```bash
$ bundle exec rake new_cop[Solidus/NameOfTheCop]
```

and then follow the instructions on the screen.

## Release a new version

To release a new version, run the following command:

```bash
$ bundle exec rake cut_release:[major|minor|patch]
```

and then follow the instructions on the screen.

The type of the release is determined by:
- `major` if there are breaking changes
- `minor` if there are new cops or new features
- `patch` if there are only bug fixes

To deploy the new version to RubyGems, run the following command:

```bash
$ bundle exec rake release
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nebulab/rubocop-solidus.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
