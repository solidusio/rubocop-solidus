# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeTDecprecated, :config do
  let(:config) { RuboCop::Config.new("Solidus/SpreeTDecprecated" => { "Enabled" => true }) }

  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<~RUBY)
      Spree.t(:solidus_store)
      ^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
    RUBY

    expect_correction(<<~RUBY)
      I18n.t('solidus_store', scope: 'spree')
    RUBY
  end

  it 'registers an offense when using `#bad_method` in a statement' do
    expect_offense(<<~RUBY)
      var = Spree.t(:solidus_store)
            ^^^^^^^^^^^^^^^^^^^^^^^ Use I18n.t instead of Spree.t which has been deprecated in future versions.
    RUBY

    expect_correction(<<~RUBY)
      var = I18n.t('solidus_store', scope: 'spree')
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      I18n.t(:solidus_store)
    RUBY
  end
end
