# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::TaxCategoryDeprecated, :config do
  let(:config) { RuboCop::Config.new }
  it 'registers an offense when using `tax_category`' do
    expect_offense(<<~RUBY)
      model.tax_category
      ^^^^^^^^^^^^^^^^^^ Solidus/TaxCategoryDeprecated: If you are Using Taxrate model use `.tax_categories = [data]` instead of `.tax_category = data`
    RUBY
  end

  it 'does not register an offense when using `tax_categories`' do
    expect_no_offenses(<<~RUBY)
      model.tax_categories
    RUBY
  end
end
