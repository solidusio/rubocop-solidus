# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds user.default_address or user.default_address and suggest
      # using user.ship_address or user.default_user_ship_address instead.
      #
      # @example
      #
      #   # bad
      #   user.default_address
      #   user.default_user_address
      #
      #   # good
      #   user.ship_address
      #   user.default_user_ship_address
      #
      class SpreeDefaultAddressDeprecated < Base
        include TargetSolidusVersion
        minimum_solidus_version 2.11

        MSG = 'user.default_address and user.default_user_address are deprecated and will be removed on Solidus 3.0. ' \
              'Please use user.ship_address or user.default_user_ship_address instead.'

        def_node_matcher :default_address?, <<~PATTERN
          (send ... :default_address)
        PATTERN

        def_node_matcher :default_user_address?, <<~PATTERN
          (send ... :default_user_address)
        PATTERN

        def on_send(node)
          return unless default_address?(node) || default_user_address?(node)

          add_offense(node, severity: :warning)
        end
      end
    end
  end
end
