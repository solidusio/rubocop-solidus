# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds discounted_amount usage and suggest using total_before_tax.
      #
      # @example EnforcedStyle:
      #   # bad
      #   discounted_amount
      #
      #   # good
      #   total_before_tax
      #
      class SpreeDiscountedAmountDeprecated < Base
        extend AutoCorrector

        MSG = 'Please use total_before_tax instead of discounted_amount.'

        def_node_matcher :discounted_amount?, <<~PATTERN
          (send nil? :discounted_amount)
        PATTERN

        def_node_matcher :discounted_amount_before_call?, <<~PATTERN
          (send ... :discounted_amount)
        PATTERN

        def_node_matcher :discounted_amount_after_call?, <<~PATTERN
          (send ... :discounted_amount ...)
        PATTERN

        def_node_matcher :discounted_amount_block_call?, <<~PATTERN
          (send ... :sum (block-pass (sym :discounted_amount)))
        PATTERN

        def on_send(node)
          return unless discounted_amount?(node) || discounted_amount_block_call?(node) ||
            discounted_amount_before_call?(node)  || discounted_amount_after_call?(node)

          add_offense(node) do |corrector|
            corrector.replace(node, node.source.gsub('discounted_amount', 'total_before_tax'))
          end
        end
      end
    end
  end
end
