# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds Spree::Calculator::FreeShipping calls.
      # This cop is needed as they have been deprecated in future version.
      #
      class SpreeCalculatorFreeShippingDeprecated < Base
        MSG = 'Spree::Calculator::FreeShipping is deprecated.'

        def_node_matcher :free_shipping?, <<~PATTERN
          (send (... (... :Calculator) :FreeShipping) $_)
        PATTERN

        def on_send(node)
          return unless free_shipping?(node)

          add_offense(node)
        end
      end
    end
  end
end
