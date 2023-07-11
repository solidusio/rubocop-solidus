# frozen_string_literal: true

module RuboCop
  module Cop
    # This module provides a way to specify a minimum Solidus version for a cop.
    # It also provides a way to check if the current Solidus version is affected.
    # The minimum Solidus version can be specified in the cop itself in this way:
    #   include TargetSolidusVersion
    #   minimum_solidus_version 2.11
    module TargetSolidusVersion
      DEFAULT_SOLIDUS_VERSION = 3.0

      def self.included(target)
        target.extend(ClassMethods)
      end

      # These class methods are automatically added to the cop when the module
      # is included. They are used to specify the minimum Solidus version for the cop.
      module ClassMethods
        def minimum_solidus_version(version)
          @minimum_solidus_version = version
        end

        def targeted_solidus_version?(version)
          @minimum_solidus_version <= version
        end
      end

      # This method overrides the one in RuboCop::Cop::Base.
      # Since this method is called for every offense, we can use it to check
      # if the Solidus version is affected and skip the offense if it's not.
      def add_offense(...)
        return unless affected_solidus_version?

        super(...)
      end

      private

      def affected_solidus_version?
        self.class.targeted_solidus_version?(target_solidus_version)
      end

      def target_solidus_version
        @target_solidus_version ||=
          config.for_all_cops['TargetSolidusVersion']&.to_f || solidus_version_from_lock_file || DEFAULT_SOLIDUS_VERSION
      end

      def solidus_version_from_lock_file
        @solidus_version_from_lock_file ||= read_solidus_version_from_lock_file
      end

      def read_solidus_version_from_lock_file
        lock_file_path = config.bundler_lock_file_path
        return nil unless lock_file_path

        File.foreach(lock_file_path) do |line|
          # If Solidus (or one of its frameworks) is in Gemfile.lock, there should be a line like:
          #   solidus_core (X.X.X)
          result = line.match(/^\s+solidus_core\s+\((\d+\.\d+)/)
          return result.captures.first.to_f if result
        end
      end
    end
  end
end
