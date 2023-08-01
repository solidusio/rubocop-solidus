# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds Spree::Refund.create(your: attributes) calls and
      # replaces them with the Spree::Refund.create(your: attributes, perform_after_create: false).perform! call.
      #
      # @example
      #
      #   # bad
      #   Spree::Refund.create(your: attributes)
      #
      #   # good
      #   Spree::Refund.create(your: attributes, perform_after_create: false).perform!
      #
      class SpreeRefundCallPerform < Base
        include TargetSolidusVersion
        minimum_solidus_version 2.11

        MSG = 'From Solidus v3.0 onwards, #perform! will need to be explicitly called when creating new refunds. ' \
              'Please, change your code from `Spree::Refund.create(your: attributes)` ' \
              'to `Spree::Refund.create(your: attributes, perform_after_create: false).perform!`'

        RESTRICT_ON_SEND = %i[create].freeze

        def_node_matcher :create_refund?, <<~PATTERN
          (send (const (const nil? :Spree) :Refund) :create ...)
        PATTERN

        def on_send(node)
          return unless create_refund?(node)

          add_offense(node)
        end
      end
    end
  end
end
