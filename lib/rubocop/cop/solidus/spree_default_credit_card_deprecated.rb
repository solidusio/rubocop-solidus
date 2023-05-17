# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds user.default_credit_card suggest using user.wallet.default_wallet_payment_source
      #
      # @example EnforcedStyle:
      #   # bad
      #   user.default_credit_card
      #
      #   # good
      #   user.wallet.default_wallet_payment_source
      #
      #
      class SpreeDefaultCreditCardDeprecated < Base
        extend AutoCorrector

        MSG = 'user.default_credit_card is deprecated. Please use user.wallet.default_wallet_payment_source instead.'

        # @!method bad_method?(node)
        def_node_matcher :default_credit_card?, <<~PATTERN
          (send ... :default_credit_card)
        PATTERN

        def on_send(node)
          return unless default_credit_card?(node)

          add_offense(node) do |corrector|
            corrector.replace(node, node.source.gsub('default_credit_card', 'wallet.default_wallet_payment_source'))
          end
        end
      end
    end
  end
end
