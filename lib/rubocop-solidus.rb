# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/solidus'
require_relative 'rubocop/solidus/version'
require_relative 'rubocop/solidus/inject'

RuboCop::Solidus::Inject.defaults!

require_relative 'rubocop/cop/solidus_cops'
