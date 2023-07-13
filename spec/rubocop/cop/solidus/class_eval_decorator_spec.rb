# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::ClassEvalDecorator, :config do
  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<~RUBY)
      Product.class_eval do
      ^^^^^^^^^^^^^^^^^^ Do not use `class_eval` flag. Use a decorator module instead. Check this link for an example https://guides.solidus.io/cookbook/redefining-checkout-steps\n
      end

    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      module ProductDecorator
      end
    RUBY
  end
end
