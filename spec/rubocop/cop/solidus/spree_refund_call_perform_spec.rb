# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeRefundCallPerform, :config do
  context 'when there is one argument' do
    it 'registers an offense when using `#create`' do
      expect_offense(<<~RUBY)
        Spree::Refund.create(your: attributes)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ From Solidus v3.0 onwards, #perform! will need to be explicitly called when creating new refunds. Please, change your code from `Spree::Refund.create(your: attributes)` to `Spree::Refund.create(your: attributes, perform_after_create: false).perform!`
      RUBY
    end
  end

  context 'when there are multiple arguments' do
    it 'registers an offense when using `#create` with multiple parameters' do
      expect_offense(<<~RUBY)
        Spree::Refund.create(your: attributes, some: others)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ From Solidus v3.0 onwards, #perform! will need to be explicitly called when creating new refunds. Please, change your code from `Spree::Refund.create(your: attributes)` to `Spree::Refund.create(your: attributes, perform_after_create: false).perform!`
      RUBY
    end
  end
end
