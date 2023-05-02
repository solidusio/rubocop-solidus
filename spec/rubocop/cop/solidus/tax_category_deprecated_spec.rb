# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::TaxCategoryDeprecated, :config do
  class TaxCategory
    # ... sample class
  end

  class Tax
    # ... sample class
  end

  let(:config) { RuboCop::Config.new('Solidus/TaxCategoryDeprecated' => { 'Enabled' => true }) }
  let(:tax) { Tax.new }

  context 'when using non-instantiated text' do
    it 'registers an offense when using `#.tax_category = `' do
      expect_offense(<<~RUBY)
        model.tax_category = data
        ^^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end

    it 'registers an offense when using `#.tax_category =`' do
      expect_offense(<<~RUBY)
        model.tax_category =data
        ^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end

    it 'registers an offense when using `#.tax_category= `' do
      expect_offense(<<~RUBY)
        model.tax_category= data
        ^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end
  end

  context 'when using TaxCategory.new assignment' do
    it 'registers an offense when using `#.tax_category = `' do
      expect_offense(<<~RUBY)
        model.tax_category = TaxCategory.new
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end

    it 'registers an offense when using `#.tax_category =`' do
      expect_offense(<<~RUBY)
        model.tax_category =TaxCategory.new
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end

    it 'registers an offense when using `#.tax_category= `' do
      expect_offense(<<~RUBY)
        model.tax_category= TaxCategory.new
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end
  end

  context 'when using Tax instance for method call' do
    it 'registers an offense when using `#.tax_category = `' do
      expect_offense(<<~RUBY)
      tax.tax_category = data
      ^^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end

    it 'registers an offense when using `#.tax_category =`' do
      expect_offense(<<~RUBY)
      tax.tax_category =data
      ^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end

    it 'registers an offense when using `#.tax_category= `' do
      expect_offense(<<~RUBY)
      tax.tax_category= data
      ^^^^^^^^^^^^^^^^^^^^^^ tax_category= is deprecated and will be removed from Solidus 3.0. Please use tax_categories= instead.
      RUBY
    end
  end
end
