# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::DiscountedAmountDeprecated, :config do
  it 'registers an offense when using .discounted_amount' do
    expect_offense(<<~RUBY)
      line_item.discounted_amount
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `.total_before_tax` instead of `.discounted_amount`.
    RUBY
  end

  it 'does not register an offense when using .total_before_tax' do
    expect_no_offenses(<<~RUBY)
      line_item.total_before_tax
    RUBY
  end
end
