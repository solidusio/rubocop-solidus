# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds .discounted_amount occurrences and suggest using .total_before_tax instead.
      #
      # @example
      #
      #   # bad
      #   line_item.discounted_amount
      #
      #   # good
      #   line_item.total_before_tax
      #
      #
      class DiscountedAmountDeprecated < Base
        include TargetSolidusVersion
        minimum_solidus_version 2.4

        MSG = 'Use `.total_before_tax` instead of `.discounted_amount`.'

        def_node_matcher :bad_method?, <<~PATTERN
          (send ... :discounted_amount)
        PATTERN

        def on_send(node)
          return unless bad_method?(node)

          add_offense(node, severity: :warning)
        end
      end
    end
  end
end
