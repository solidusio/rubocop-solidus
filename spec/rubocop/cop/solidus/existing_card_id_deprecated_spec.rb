# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::ExistingCardIdDeprecated, :config do
  it 'registers an offense when using `existing_card_id`' do
    expect_offense(<<~RUBY, severity: :warning)
      existing_card_id
      ^^^^^^^^^^^^^^^^ Use `wallet_payment_source_id` instead of `existing_card_id`.
    RUBY
  end

  it 'does not register an offense when using `wallet_payment_source_id`' do
    expect_no_offenses(<<~RUBY)
      wallet_payment_source_id
    RUBY
  end
end
