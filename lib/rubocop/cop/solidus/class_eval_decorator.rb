# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      #
      # @example EnforcedStyle: SpreeClass
      #   # Description of the `SpreeClass` style.
      #
      #   # bad
      #   SpreeClass.class_eval do
      #   .
      #   .
      #   end
      #
      #
      #   # good
      #   module SpreeClassDecorator
      #   .
      #   .
      #   end
      #
      class ClassEvalDecorator < Base
        MSG = 'Do not use `class_eval` flag. Use a decorator module instead. Check this link for an example https://guides.solidus.io/cookbook/redefining-checkout-steps'

        # TODO: Don't call `on_send` unless the method name is in this list
        # If you don't need `on_send` in the cop you created, remove it.
        RESTRICT_ON_SEND = %i[class_eval].freeze

        # @!method on_class_eval?(node)
        def_node_matcher :on_class_eval?, <<~PATTERN
          (send  ($...) :class_eval)
        PATTERN

        def on_send(node)
          return unless on_class_eval?(node)

          add_offense(node)
        end
      end
    end
  end
end
