# frozen_string_literal: true

module RuboCop
  module Cop
    # Common functionality for checking target solidus version.
    module TargetSolidusVersion
      DEFAULT_SOLIDUS_VERSION = '3.0'
      RUBOCOP_SOLIDUS_HOME = File.realpath(File.join(File.dirname(__FILE__), '..', '..', '..', '..')).freeze
      DOTFILE = '.rubocop.yml'

      def minimum_supported_solidus_version?(version)
        version <= solidus_version
      end

      private

      def solidus_version
        @solidus_version ||= config.exist? ? YAML.load_file(config)['AllCops']['TargetSolidusVersion'] : DEFAULT_SOLIDUS_VERSION
      end

      def config
        @config ||= File.join(RUBOCOP_SOLIDUS_HOME, DOTFILE)
      end
    end
  end
end
