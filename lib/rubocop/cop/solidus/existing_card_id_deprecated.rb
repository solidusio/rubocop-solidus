# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds existing_card_id occurrences and suggest using wallet_payment_source_id instead.
      #
      # @example
      #
      #   # bad
      #   {
      #     name: payment_method.name,
      #     existing_card_id: payment_source.id
      #   }
      #
      #   # good
      #   {
      #     name: payment_method.name,
      #     wallet_payment_source_id: payment_source.wallet.wallet_payment_sources.first.id
      #   }
      #
      class ExistingCardIdDeprecated < Base
        include TargetSolidusVersion
        minimum_solidus_version 2.2

        MSG = 'Use `wallet_payment_source_id` instead of `existing_card_id`.'

        def_node_matcher :existing_card_id?, <<~PATTERN
          (send ... :existing_card_id)
        PATTERN

        def on_send(node)
          return unless existing_card_id?(node)

          add_offense(node, severity: :warning)
        end
      end
    end
  end
end
