# frozen_string_literal: true

require_relative 'lib/rubocop/solidus/version'

Gem::Specification.new do |spec|
  spec.name = 'rubocop-solidus'
  spec.version = RuboCop::Solidus::VERSION
  spec.authors = ['piyushswain']
  spec.email = ['piyush.swain3@gmail.com']

  spec.summary = 'Automatic Solidus code style checking tool.'
  spec.description = <<~DESCRIPTION
    Automatic Solidus code style checking tool.
    A RuboCop extension focused on enforcing Solidus best practices and coding conventions.
  DESCRIPTION
  spec.homepage = 'https://www.github.com/nebulab/rubocop-solidus'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.4.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://www.github.com/nebulab/rubocop-solidus'
  spec.metadata['changelog_uri'] = 'https://www.github.com/nebulab/rubocop-solidus'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_runtime_dependency 'rubocop'
end
