# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Solidus::SpreeIconDeprecated, :config do
  it 'registers an offense when using `#icon("example")`' do
    expect_offense(<<~RUBY)
      helper.icon('example')
      ^^^^^^^^^^^^^^^^^^^^^^ In Solidus 2.3, `icon` helper has been deprecated in favor of `solidus_icon`
    RUBY
  end

  it 'registers an offense when using `#icon("")`' do
    expect_offense(<<~RUBY)
      helper.icon('')
      ^^^^^^^^^^^^^^^ In Solidus 2.3, `icon` helper has been deprecated in favor of `solidus_icon`
    RUBY
  end

  it 'does not register an offense when using `#solidus_icon`' do
    expect_no_offenses(<<~RUBY)
      helper.solidus_icon('example')
    RUBY
  end
end
