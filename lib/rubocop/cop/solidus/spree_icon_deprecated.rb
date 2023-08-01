# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds icon helper calls and suggest using solidus_icon.
      #
      # @example
      #
      #   # bad
      #   helper.icon('example')
      #
      #   # good
      #   helper.solidus_icon('example')
      #
      class SpreeIconDeprecated < Base
        extend AutoCorrector
        include TargetSolidusVersion
        minimum_solidus_version 2.3

        MSG = 'In Solidus 2.3, `icon` helper has been deprecated in favor of `solidus_icon`'

        RESTRICT_ON_SEND = %i[icon].freeze

        def_node_matcher :icon?, <<~PATTERN
          (send (send nil? ...) :icon ...)
        PATTERN

        def on_send(node)
          return unless icon?(node)

          add_offense(node) do |corrector|
            corrector.replace(node, node.source.gsub('icon', 'solidus_icon'))
          end
        end
      end
    end
  end
end
