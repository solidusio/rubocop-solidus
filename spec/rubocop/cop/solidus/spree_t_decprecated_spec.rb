# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeTDecprecated, :config do
  describe 'first argument is a symbol' do
    it 'registers an offense when using `#bad_method`' do
      expect_offense(<<~RUBY)
        Spree.t(:solidus_store)
        ^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t(:solidus_store, scope: :spree)
      RUBY
    end

    it 'registers an offense when using `#bad_method` with custom scope' do
      expect_offense(<<~RUBY)
        Spree.t(:solidus_store, scope: [:custom_scope])
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t(:solidus_store, scope: [:spree, :custom_scope])
      RUBY
    end

    it 'registers an offense when using `#bad_method` with custom scope and custom arguments' do
      expect_offense(<<~RUBY)
        Spree.t(:solidus_store, scope: [:custom_scope], email: params[:email])
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t(:solidus_store, scope: [:spree, :custom_scope], email: params[:email])
      RUBY
    end

    it 'registers an offense when using `#bad_method` in a statement' do
      expect_offense(<<~RUBY)
        var = Spree.t(:solidus_store)
              ^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        var = I18n.t(:solidus_store, scope: :spree)
      RUBY
    end

    it 'registers an offense when using `#bad_method` with a string scope' do
      expect_offense(<<~RUBY)
        Spree.t(:solidus_store, scope: 'admin.compositions')
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t(:solidus_store, scope: 'spree.admin.compositions')
      RUBY
    end

    it 'registers an offense when using `#bad_method` without scope argument and with other arguments' do
      expect_offense(<<~RUBY)
        Spree.t(:solidus_store, address_button: address_button).html_safe
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t(:solidus_store, scope: :spree, address_button: address_button).html_safe
      RUBY
    end

    it 'does not register an offense when using `#good_method` with string for scope' do
      expect_no_offenses(<<~RUBY)
        I18n.t(:solidus_store, scope: 'spree')
      RUBY
    end

    it 'does not register an offense when using `#good_method`' do
      expect_no_offenses(<<~RUBY)
        I18n.t(:solidus_store, scope: :spree)
      RUBY
    end

    it 'does not register an offense when using `#good_method` with custom scope' do
      expect_no_offenses(<<~RUBY)
        I18n.t(:solidus_store, scope: [:custom_scope])
      RUBY
    end

    it 'does not register an offense when using `#good_method` with custom scope and custom arguments' do
      expect_no_offenses(<<~RUBY)
        I18n.t(:solidus_store, scope: [:custom_scope], email: params[:email])
      RUBY
    end
  end

  describe 'first argument is a string' do
    it 'registers an offense when using `#bad_method`' do
      expect_offense(<<~RUBY)
        Spree.t('solidus_store')
        ^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t('solidus_store', scope: :spree)
      RUBY
    end

    it 'registers an offense when using `#bad_method` with custom scope' do
      expect_offense(<<~RUBY)
        Spree.t('solidus_store', scope: [:custom_scope])
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t('solidus_store', scope: [:spree, :custom_scope])
      RUBY
    end

    it 'registers an offense when using `#bad_method` with custom scope and custom arguments' do
      expect_offense(<<~RUBY)
        Spree.t('solidus_store', scope: [:custom_scope], email: params[:email])
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t('solidus_store', scope: [:spree, :custom_scope], email: params[:email])
      RUBY
    end

    it 'registers an offense when using `#bad_method` in a statement' do
      expect_offense(<<~RUBY)
        var = Spree.t('solidus_store')
              ^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        var = I18n.t('solidus_store', scope: :spree)
      RUBY
    end

    it 'registers an offense when using `#bad_method` with a string scope' do
      expect_offense(<<~RUBY)
        Spree.t('solidus_store', scope: 'admin.compositions')
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t('solidus_store', scope: 'spree.admin.compositions')
      RUBY
    end

    it 'registers an offense when using `#bad_method` without scope argument and with other arguments' do
      expect_offense(<<~RUBY)
        Spree.t('solidus_store', address_button: address_button).html_safe
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
      RUBY

      expect_correction(<<~RUBY)
        I18n.t('solidus_store', scope: :spree, address_button: address_button).html_safe
      RUBY
    end

    it 'does not register an offense when using `#good_method`' do
      expect_no_offenses(<<~RUBY)
        I18n.t('solidus_store', scope: :spree)
      RUBY
    end

    it 'does not register an offense when using `#good_method` with string for scope' do
      expect_no_offenses(<<~RUBY)
        I18n.t('solidus_store', scope: 'spree')
      RUBY
    end

    it 'does not register an offense when using `#good_method` with custom scope' do
      expect_no_offenses(<<~RUBY)
        I18n.t('solidus_store', scope: [:custom_scope])
      RUBY
    end

    it 'does not register an offense when using `#good_method` with custom scope and custom arguments' do
      expect_no_offenses(<<~RUBY)
        I18n.t('solidus_store', scope: [:custom_scope], email: params[:email])
      RUBY
    end
  end
end
