# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeDefaultCreditCardDeprecated, :config do
  it 'registers an offense when using `#.default_credit_card`' do
    expect_offense(<<~RUBY)
      user.default_credit_card
      ^^^^^^^^^^^^^^^^^^^^^^^^ user.default_credit_card is deprecated. Please use user.wallet.default_wallet_payment_source instead.
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      user.wallet.default_wallet_payment_source
    RUBY
  end
end
