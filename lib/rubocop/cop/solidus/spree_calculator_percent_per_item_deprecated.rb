# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds Spree::Calculator::PercentPerItem calls.
      # This cop is needed as they have been deprecated in future version.
      #
      # @example
      #
      #   # bad
      #   Spree::Calculator::PercentPerItem
      #
      #   # good
      #   Spree::Calculator::PercentOnLineItem
      #
      class SpreeCalculatorPercentPerItemDeprecated < Base
        extend AutoCorrector

        MSG = 'Spree::Calculator::PercentPerItem is deprecated. Use Spree::Calculator::PercentOnLineItem instead.'

        def_node_matcher :percent_per_item?, <<~PATTERN
          (send (... (... :Calculator) :PercentPerItem) $_)
        PATTERN

        def on_send(node)
          percent_per_item?(node) do |method_used|
            add_offense(node, message: MSG) do |corrector|
              corrector.replace(node, "Spree::Calculator::PercentOnLineItem.#{method_used}")
            end
          end
        end
      end
    end
  end
end
