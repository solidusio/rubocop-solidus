# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # Solidus suggests a decorator module instead of `class_eval` when overriding some features.
      # This cop finds any `class_eval` and asks to use a decorator module instead.
      # More info: https://guides.solidus.io/customization/customizing-the-core.
      #
      # @example
      #
      #   # bad
      #   SpreeClass.class_eval do
      #     # your code here
      #   end
      #
      #   # good
      #   module Spree
      #     module SpreeClassDecorator
      #       # your code here
      #     end
      #
      #     Spree::SpreeClass.prepend self
      #   end
      #
      class ClassEvalDecorator < Base
        MSG = 'Do not use `class_eval` flag. Use a decorator module instead. More info: https://guides.solidus.io/customization/customizing-the-core.'

        RESTRICT_ON_SEND = %i[class_eval].freeze

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
