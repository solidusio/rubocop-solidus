# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds .tax_category occurrences and suggest using .tax_categories instead.
      #
      # @example
      #
      #   # bad
      #     model.tax_category = data
      #
      #   # good
      #     model.tax_categories = [data]
      #
      #
      #
      class TaxCategoryDeprecated < Base
        include TargetSolidusVersion
        minimum_solidus_version 2.2

        MSG = 'If you are Using Taxrate model use `.tax_categories = [data]` instead of `.tax_category = data`'

        def_node_matcher :existing_tax_category?, <<~PATTERN
          (send ... :tax_category)
        PATTERN

        def on_send(node)
          return unless existing_tax_category?(node)

          add_offense(node, severity: :warning)
        end
      end
    end
  end
end
