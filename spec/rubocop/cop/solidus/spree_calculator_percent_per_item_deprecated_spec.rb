# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeCalculatorPercentPerItemDeprecated, :config do
  context 'when calling #new' do
    it 'registers an offense when using `#new`' do
      expect_offense(<<~RUBY)
        Spree::Calculator::PercentPerItem.new
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Calculator::PercentPerItem is deprecated.
      RUBY
    end

    it 'does not register an offense when using `#new`' do
      expect_no_offenses(<<~RUBY)
        Spree::Calculator::PercentOnLineItem.new
      RUBY
    end
  end

  context 'when calling #create' do
    it 'registers an offense when using `#create`' do
      expect_offense(<<~RUBY)
        Spree::Calculator::PercentPerItem.create
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Calculator::PercentPerItem is deprecated.
      RUBY
    end

    it 'does not register an offense when using `#create`' do
      expect_no_offenses(<<~RUBY)
        Spree::Calculator::PercentOnLineItem.create
      RUBY
    end
  end
end
