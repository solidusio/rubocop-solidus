# Rubocop::Solidus

Automatic Solidus code style checking tool.
A RuboCop extension focused on enforcing Solidus best practices and coding conventions.

## Getting started

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-solidus', require: false
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubocop-solidus

### Usage

To Start using this extension in your application add the following lines to your `.rubocop.yml` file

```yaml
require:
    - rubocop-solidus
```


After this^, simply use the `rubocop` command to start linting your Ruby(`.rb`) files.

### For linting `.erb` files

We recommend to run rubocop solidus cops on ERB files. The simplest method to do this is via
[erblint](https://github.com/Shopify/erb-lint)

#### Add ERBlint to your Gemfile
```ruby
  gem 'erb_lint'
```

#### Add ERBlint config (`.erb-lint.yml`)
This is the most basic ERBlint config that can be used to run all and only the Solidus cops in any project
```yaml
---
EnableDefaultLinters: false
linters:
  Rubocop:
    enabled: true
    rubocop_config:
      inherit_from:
        - .rubocop.yml
    only:
      - Solidus
```

#### To run ERBlint for all ERB files
```bash
# From project directory
bundle exec erblint .
```

#### To run autocorrect on ERB files
Any cop that supports autocorrect for rubocop implicitly supports autocorrect
for ERB files as well.
```bash
# From project directory
bundle exec erblint -a .
```

## Documentation

You can read about each cop supplied by RuboCop Solidus in [the docs](https://solidusio.github.io/rubocop-solidus/).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/solidusio/rubocop-solidus.

To contribute a new cop, please see the sections below.

### Creating new cops

To create a new cop, run the following command:

```bash
$ bundle exec rake 'new_cop[Solidus/NameOfTheCop]'
```

and then follow the instructions on the screen.

### Creating changelog entries

Changelog entries are just files under the `changelog/` folder that will be merged
into `CHANGELOG.md` at release time. You can create new changelog entries like this:

```console
$ bundle exec rake changelog:new|fix|change
```

The type of the changelog correspond to "new feature", "bug-fix" and "changed" entries in the changelog.

#### Changelog entry format

Here are a few examples:

```markdown
* [#46](https://github.com/solidusio/rubocop-solidus/issues/46): **(Breaking)** Remove support for old Ruby versions. ([@MassimilianoLattanzio][])
* [#4](https://github.com/solidusio/rubocop-solidus/pull/4): Update CHANGELOG. ([@piyushswain][])
```

* Create one file `changelog/{type}_{some_description}.md`, where `type` is `new` (New feature), `fix` or `change`, and `some_description` is unique to avoid conflicts. Task `changelog:fix` (or `:new` or `:change`) can help you.
* Mark it up in [Markdown syntax][1].
* The entry should be a single line, starting with `* ` (an asterisk and a space).
* If the change has a related GitHub issue (e.g. a bug fix for a reported issue), put a link to the issue as `[#123](https://github.com/solidusio/rubocop-solidus/issues/123): `.
* Describe the brief of the change. The sentence should end with a punctuation.
* If this is a breaking change, mark it with `**(Breaking)**`.
* At the end of the entry, add an implicit link to your GitHub user page as `([@username][])`.

### Release a new version

To release a new version, run the following command:

```bash
$ bundle exec rake cut_release:major|minor|patch
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

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[1]: https://www.markdownguide.org/basic-syntax/
