# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeCalculatorPriceSackDeprecated, :config do
  let(:config) { RuboCop::Config.new('Solidus/SpreeCalculatorPriceSackDeprecated' => { 'Enabled' => true }) }

  context 'when using `Spree::Calculator::PriceSack` class' do
    it 'registers an offense when using `#new`' do
      expect_offense(<<~RUBY)
        Spree::Calculator::PriceSack.new
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Calculator::PriceSack is deprecated.
      RUBY
    end

    it 'registers an offense when using `#create`' do
      expect_offense(<<~RUBY)
        Spree::Calculator::PriceSack.create
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Calculator::PriceSack is deprecated.
      RUBY
    end
  end
end
