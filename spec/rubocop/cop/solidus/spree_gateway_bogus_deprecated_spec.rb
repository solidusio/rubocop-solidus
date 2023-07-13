# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeGatewayBogusDeprecated, :config do
  describe 'using #new' do
    it 'registers an offense when using `#bad_method`' do
      expect_offense(<<~RUBY)
        Spree::Gateway::Bogus.new
        ^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Gateway::Bogus is deprecated. Please use Spree::PaymentMethod::BogusCreditCard instead.
      RUBY

      expect_correction(<<~RUBY)
        Spree::PaymentMethod::BogusCreditCard.new
      RUBY
    end

    it 'does not register an offense when using `#good_method`' do
      expect_no_offenses(<<~RUBY)
        Spree::PaymentMethod::BogusCreditCard.new
      RUBY
    end
  end

  describe 'using #create' do
    it 'registers an offense when using `#bad_method`' do
      expect_offense(<<~RUBY)
        Spree::Gateway::Bogus.create
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Gateway::Bogus is deprecated. Please use Spree::PaymentMethod::BogusCreditCard instead.
      RUBY

      expect_correction(<<~RUBY)
        Spree::PaymentMethod::BogusCreditCard.create
      RUBY
    end

    it 'does not register an offense when using `#good_method`' do
      expect_no_offenses(<<~RUBY)
        Spree::PaymentMethod::BogusCreditCard.create
      RUBY
    end
  end

  describe 'using #create!' do
    it 'registers an offense when using `#bad_method`' do
      expect_offense(<<~RUBY)
        Spree::Gateway::Bogus.create!
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Spree::Gateway::Bogus is deprecated. Please use Spree::PaymentMethod::BogusCreditCard instead.
      RUBY

      expect_correction(<<~RUBY)
        Spree::PaymentMethod::BogusCreditCard.create!
      RUBY
    end

    it 'does not register an offense when using `#good_method`' do
      expect_no_offenses(<<~RUBY)
        Spree::PaymentMethod::BogusCreditCard.create!
      RUBY
    end
  end
end
