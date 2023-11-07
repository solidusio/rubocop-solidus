# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeDefaultAddressDeprecated, :config do
  it 'registers an offense when using `#.default_address`' do
    expect_offense(<<~RUBY, severity: :warning)
      user.default_address
      ^^^^^^^^^^^^^^^^^^^^ user.default_address and user.default_user_address are deprecated and will be removed on Solidus 3.0. Please use user.ship_address or user.default_user_ship_address instead.
    RUBY
  end

  it 'does not register an offense when using `#ship_address`' do
    expect_no_offenses(<<~RUBY)
      user.ship_address
    RUBY
  end

  it 'registers an offense when using `#.default_user_address`' do
    expect_offense(<<~RUBY, severity: :warning)
      user.default_user_address
      ^^^^^^^^^^^^^^^^^^^^^^^^^ user.default_address and user.default_user_address are deprecated and will be removed on Solidus 3.0. Please use user.ship_address or user.default_user_ship_address instead.
    RUBY
  end

  it 'does not register an offense when using `#default_user_ship_address`' do
    expect_no_offenses(<<~RUBY)
      user.default_user_ship_address
    RUBY
  end
end
