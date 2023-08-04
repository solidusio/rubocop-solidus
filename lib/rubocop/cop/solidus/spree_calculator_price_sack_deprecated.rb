# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds Spree::Calculator::PriceSack calls.
      # This cop is needed as they have been deprecated in future version.
      #
      # @example
      #
      #   # bad
      #   Spree::Calculator::PriceSack
      #
      #   # good
      #
      class SpreeCalculatorPriceSackDeprecated < Base
        MSG = 'Spree::Calculator::PriceSack is deprecated.'

        def_node_matcher :price_sack?, <<~PATTERN
          (send (... (... :Calculator) :PriceSack) $_)
        PATTERN

        def on_send(node)
          return unless price_sack?(node)

          add_offense(node)
        end
      end
    end
  end
end
