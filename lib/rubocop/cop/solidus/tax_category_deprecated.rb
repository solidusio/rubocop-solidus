# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds tax_category= usages and suggests the usage of tax_categories= instead.
      # This cop is needed as tax_category= has been deprecated in future version.
      #
      # @example EnforcedStyle:
      #   # bad
      #   model.tax_category = data
      #
      #   # good
      #   model.tax_categories = [data]
      #
      class TaxCategoryDeprecated < Base
        MSG = 'tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.'

        # @!method bad_method?(node)
        def_node_matcher :tax_category?, <<~PATTERN
          (send (...) :tax_category= (...))
        PATTERN

        def on_send(node)
          return unless tax_category?(node)

          add_offense(node)
        end
      end
    end
  end
end
