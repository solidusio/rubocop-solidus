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
      #   I18n.t(:bar, scope: :spree)
      #
      #   # bad
      #   Spree.t(:bar, scope: [:city])
      #
      #   # good
      #   I18n.t(:bar, scope: [:spree, :city])
      #
      #   # bad
      #   Spree.t(:bar, scope: [:city], email: email)
      #
      #   # good
      #   I18n.t(:bar, scope: [:spree, :city], email: email)
      #
      #   # bad
      #   Spree.t('bar', scope: 'admin.city')
      #
      #   # good
      #   I18n.t('bar', scope: 'spree.admin.city')
      #
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
            corrector.replace(node, corrected_statement(node))
          end
        end

        # rubocop:disable Metrics/MethodLength
        def corrected_statement(node)
          arguments = node.arguments

          new_statement = 'I18n.t('
          new_statement += arguments.first.source
          new_statement += ', scope: :spree' if scope_missing?(arguments)

          node.arguments.drop(1).each do |argument|
            if argument.source.include? 'scope:'
              new_argument = add_spree_scope(argument)
              new_statement += ", #{new_argument}"
            else
              new_statement += ", #{argument.source}"
            end
          end
          new_statement += ')'
          new_statement
        end
        # rubocop:enable Metrics/MethodLength

        def scope_missing?(arguments)
          arguments.each do |argument|
            return false if argument.source.include? 'scope:'
          end
          true
        end

        # rubocop:disable Metrics/MethodLength
        def add_spree_scope(argument)
          modified_argument = ''

          argument.each_pair do |key, value|
            if key.source == 'scope'
              modified_argument = if value.type == :array
                                    "#{key.source}: #{value.source.gsub('[', '[:spree, ')}"
                                  else
                                    "#{key.source}: 'spree.#{value.source.gsub("'", '')}'"
                                  end
            else
              modified_argument += ", #{key.source}: #{value.source}"
            end
          end

          modified_argument
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
