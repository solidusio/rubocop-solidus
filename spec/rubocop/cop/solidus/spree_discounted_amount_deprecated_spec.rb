# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeDiscountedAmountDeprecated, :config do
  let(:config) { RuboCop::Config.new('Solidus/SpreeDiscountedAmountDeprecated' => { 'Enabled' => true }) }

  it 'registers an offense when using `#discounted_amount`' do
    expect_offense(<<~RUBY)
      discounted_amount
      ^^^^^^^^^^^^^^^^^ Please use total_before_tax instead of discounted_amount.
    RUBY
  end

  it 'does not register an offense when using `#total_before_tax`' do
    expect_no_offenses(<<~RUBY)
      total_before_tax
    RUBY
  end

  it 'registers an offense when using `#&:discounted_amount`' do
    expect_offense(<<~RUBY)
      matched_line_items.sum(&:discounted_amount)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please use total_before_tax instead of discounted_amount.
    RUBY
  end

  it 'does not register an offense when using `#&:total_before_tax`' do
    expect_no_offenses(<<~RUBY)
      matched_line_items.sum(&:total_before_tax)
    RUBY
  end

  it 'registers an offense when using `#.discounted_amount`' do
    expect_offense(<<~RUBY)
      item.discounted_amount
      ^^^^^^^^^^^^^^^^^^^^^^ Please use total_before_tax instead of discounted_amount.
    RUBY
  end

  it 'does not register an offense when using `#.total_before_tax`' do
    expect_no_offenses(<<~RUBY)
      item.total_before_tax
    RUBY
  end
end
