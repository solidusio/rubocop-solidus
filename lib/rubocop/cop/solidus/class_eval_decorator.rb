# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      class ClassEvalDecorator < Base
        extend TargetRailsVersion
        MSG = "Do not use `class_eval` flag. Use a decorator module instead. Check this link for an example https://guides.solidus.io/cookbook/redefining-checkout-steps"

        # TODO: Don't call `on_send` unless the method name is in this list
        # If you don't need `on_send` in the cop you created, remove it.
        RESTRICT_ON_SEND = %i[class_eval].freeze

        # @!method on_class_eval?(node)
        def_node_matcher :on_class_eval?, <<~PATTERN
          (send  ($...) :class_eval)
        PATTERN

        def on_send(node)
          return unless on_class_eval?(node)
          return unless minimum_supported_solidus_version?(3.0)

          add_offense(node)
        end
      end
    end
  end
end
