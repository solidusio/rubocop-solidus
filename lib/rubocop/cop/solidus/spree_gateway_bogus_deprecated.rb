# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds Spree::Gateway::Bogus calls and replaces them with the Spree::PaymentMethod::BogusCreditCard call
      # This cop is needed as the Spree::Gateway::Bogus has been deprecated in future version.
      #
      # @example EnforcedStyle:
      #   # bad
      #   Spree::Gateway::Bogus.new
      #
      #   # good
      #   Spree::PaymentMethod::BogusCreditCard.new
      #
      #   # bad
      #   Spree::Gateway::Bogus.create
      #
      #   # good
      #   Spree::PaymentMethod::BogusCreditCard.create
      #
      #   # bad
      #   Spree::Gateway::Bogus.create!
      #
      #   # good
      #   Spree::PaymentMethod::BogusCreditCard.create!
      #
      #
      class SpreeGatewayBogusDeprecated < Base
        extend AutoCorrector
        include TargetSolidusVersion
        minimum_solidus_version 2.10

        MSG = 'Spree::Gateway::Bogus is deprecated. Please use Spree::PaymentMethod::BogusCreditCard instead.'

        # @!method bad_method?(node)
        def_node_matcher :bad_class?, <<~PATTERN
          (send (... (... :Gateway) :Bogus) $_)
        PATTERN

        def on_send(node)
          bad_class?(node) do |method_used|
            add_offense(node, message: MSG) do |corrector|
              corrector.replace(node, "Spree::PaymentMethod::BogusCreditCard.#{method_used}")
            end
          end
        end
      end
    end
  end
end
