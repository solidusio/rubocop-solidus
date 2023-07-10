# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeCalculatorFreeShippingDeprecated, :config do
  context 'when using `Spree::Calculator::FreeShipping` class' do
    it 'registers an offense when using `#new`' do
      expect_offense(<<~RUBY)
        Spree::Calculator::FreeShipping.new
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Calculator::FreeShipping is deprecated.
      RUBY
    end

    it 'registers an offense when using `#create`' do
      expect_offense(<<~RUBY)
        Spree::Calculator::FreeShipping.create
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Calculator::FreeShipping is deprecated.
      RUBY
    end
  end
end
