# frozen_string_literal: true

module RuboCop
  module Cop
    module Solidus
      # This cop finds reimbursement_success_hooks and reimbursement_failed_hooks calls and
      # asks to remove them and subscribe to reimbursement_reimbursed event instead.
      class ReimbursementHookDeprecated < Base
        include TargetSolidusVersion
        minimum_solidus_version 2.11

        MSG = 'Please remove reimbursement_success_hooks and reimbursement_failed_hooks. ' \
              'Subscribe to reimbursement_reimbursed event instead.'

        def_node_matcher :success_hook?, <<~PATTERN
          (send (send nil? :reimbursement_success_hooks) ...)
        PATTERN

        def_node_matcher :fail_hook?, <<~PATTERN
          (send (send nil? :reimbursement_failed_hooks) ...)
        PATTERN

        def on_send(node)
          return unless success_hook?(node) || fail_hook?(node)

          add_offense(node)
        end
      end
    end
  end
end
