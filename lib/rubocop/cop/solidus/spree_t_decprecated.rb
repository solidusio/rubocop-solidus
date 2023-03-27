# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds Spree.t method calls and replaces them with the I18n,t method call
      # This cop is needed as the Spree.t version has been deprecated in future version.
      #
      #
      # @example EnforcedStyle: bar (default)
      #   # bad
      #   Spree.t(:bar)
      #
      #   # good
      #   I18n.t(:bar)
      #
      #   # good
      #   good_bar_method(args)
      #
      class SpreeTDecprecated < Base
        extend AutoCorrector
        MSG = 'Use I18n.t instead of Spree.t which has been deprecated in future versions.'

        RESTRICT_ON_SEND = %i[t].freeze

        # @!method spree_t?(node)
        def_node_matcher :spree_t?, <<~PATTERN
          (send ($...) :t ...)
        PATTERN

        def on_send(node)
          return unless spree_t?(node)

          return unless spree_t?(node).include?(:Spree)

          add_offense(node) do |corrector|
            corrector.replace(node, "I18n.t('#{node.first_argument.source.to_s.gsub(':', '')}', scope: 'spree')")
          end
        end
      end
    end
  end
end
