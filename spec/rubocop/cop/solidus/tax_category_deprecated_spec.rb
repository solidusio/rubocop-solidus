# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::TaxCategoryDeprecated, :config do
  let(:config) { RuboCop::Config.new('Solidus/TaxCategoryDeprecated' => { 'Enabled' => true }) }

  it 'registers a warning when using `#.tax_category = `' do
    expect_offense(<<~RUBY, severity: :warning)
      model.tax_category = data
      ^^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead. If this call is not from a Spree::TaxRate object then it is false positive.
    RUBY
  end

  it 'registers a warning when using `#.tax_category =`' do
    expect_offense(<<~RUBY, severity: :warning)
      model.tax_category =data
      ^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead. If this call is not from a Spree::TaxRate object then it is false positive.
    RUBY
  end

  it 'registers a warning when using `#.tax_category= `' do
    expect_offense(<<~RUBY, severity: :warning)
      model.tax_category= data
      ^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead. If this call is not from a Spree::TaxRate object then it is false positive.
    RUBY
  end

  it 'does not register any offense when using `#.tax_categories=`' do
    expect_no_offenses(<<~RUBY)
      model.tax_categories = [data]
    RUBY
  end
end
