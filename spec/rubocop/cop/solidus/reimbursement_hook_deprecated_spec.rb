# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::ReimbursementHookDeprecated, :config do
  it 'registers an offense when using `#reimbursement_success_hooks.any?`' do
    expect_offense(<<~RUBY)
      reimbursement_success_hooks.any?
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please remove reimbursement_success_hooks and reimbursement_failed_hooks. Subscribe to reimbursement_reimbursed event instead.
    RUBY
  end

  it 'registers an offense when using `#reimbursement_success_hooks.each`' do
    expect_offense(<<~RUBY)
      reimbursement_success_hooks.each
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please remove reimbursement_success_hooks and reimbursement_failed_hooks. Subscribe to reimbursement_reimbursed event instead.
    RUBY
  end

  it 'registers an offense when using `#reimbursement_failed_hooks.any?`' do
    expect_offense(<<~RUBY)
      reimbursement_failed_hooks.any?
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please remove reimbursement_success_hooks and reimbursement_failed_hooks. Subscribe to reimbursement_reimbursed event instead.
    RUBY
  end

  it 'registers an offense when using `#reimbursement_failed_hooks.each`' do
    expect_offense(<<~RUBY)
      reimbursement_failed_hooks.each
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please remove reimbursement_success_hooks and reimbursement_failed_hooks. Subscribe to reimbursement_reimbursed event instead.
    RUBY
  end
end
