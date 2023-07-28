# Solidus

## Solidus/ClassEvalDecorator

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | 0.1.0 | -

TODO: Write cop description and example of bad / good code. For every
`SupportedStyle` and unique configuration, there needs to be examples.
Examples must have valid Ruby syntax. Do not use upticks.

### Examples

#### EnforcedStyle: SpreeClass

```ruby
# Description of the `SpreeClass` style.

# bad
SpreeClass.class_eval do
.
.
end

# good
module SpreeClassDecorator
.
.
end
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/21](https://github.com/solidusio/rubocop-solidus/issues/21)

## Solidus/ReimbursementHookDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | 0.1.0 | -

This cop finds reimbursement_success_hooks and reimbursement_failed_hooks calls and
asks to remove them and subscribe to reimbursement_reimbursed event instead.

### References

* [https://github.com/solidusio/rubocop-solidus/issues/27](https://github.com/solidusio/rubocop-solidus/issues/27)

## Solidus/SpreeCalculatorFreeShippingDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | 0.1.0 | -

This cop finds Spree::Calculator::FreeShipping calls.
This cop is needed as they have been deprecated in future version.

### References

* [https://github.com/solidusio/rubocop-solidus/issues/29](https://github.com/solidusio/rubocop-solidus/issues/29)

## Solidus/SpreeCalculatorPercentPerItemDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1.0 | -

This cop finds Spree::Calculator::PercentPerItem calls.
This cop is needed as they have been deprecated in future version.

### References

* [https://github.com/solidusio/rubocop-solidus/issues/29](https://github.com/solidusio/rubocop-solidus/issues/29)

## Solidus/SpreeCalculatorPriceSackDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | 0.1.0 | -

This cop finds Spree::Calculator::PriceSack calls.
This cop is needed as they have been deprecated in future version.

### References

* [https://github.com/solidusio/rubocop-solidus/issues/29](https://github.com/solidusio/rubocop-solidus/issues/29)

## Solidus/SpreeDefaultCreditCardDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1.0 | -

This cop finds user.default_credit_card suggest using user.wallet.default_wallet_payment_source

### Examples

#### EnforcedStyle:

```ruby
# bad
user.default_credit_card

# good
user.wallet.default_wallet_payment_source
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/33](https://github.com/solidusio/rubocop-solidus/issues/33)

## Solidus/SpreeGatewayBogusDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1.0 | -

This cop finds Spree::Gateway::Bogus calls and replaces them with the Spree::PaymentMethod::BogusCreditCard call
This cop is needed as the Spree::Gateway::Bogus has been deprecated in future version.

### Examples

#### EnforcedStyle:

```ruby
# bad
Spree::Gateway::Bogus.new

# good
Spree::PaymentMethod::BogusCreditCard.new

# bad
Spree::Gateway::Bogus.create

# good
Spree::PaymentMethod::BogusCreditCard.create

# bad
Spree::Gateway::Bogus.create!

# good
Spree::PaymentMethod::BogusCreditCard.create!
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/26](https://github.com/solidusio/rubocop-solidus/issues/26)

## Solidus/SpreeIconDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1.0 | -

This cop finds icon helper calls and suggest using solidus_icon

### Examples

#### EnforcedStyle:

```ruby
# bad
helper.icon('example')

# good
helper.solidus_icon('example')
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/32](https://github.com/solidusio/rubocop-solidus/issues/32)

## Solidus/SpreeRefundCallPerform

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | 0.1.0 | -

This cop finds Spree::Refund.create(your: attributes) calls and
replaces them with the Spree::Refund.create(your: attributes, perform_after_create: false).perform! call

### References

* [https://github.com/solidusio/rubocop-solidus/issues/28](https://github.com/solidusio/rubocop-solidus/issues/28)

## Solidus/SpreeTDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1.0 | -

This cop finds Spree.t method calls and replaces them with the I18n,t method call
This cop is needed as the Spree.t version has been deprecated in future version.

### Examples

#### EnforcedStyle: bar (default)

```ruby
# bad
Spree.t(:bar)

# good
I18n.t(:bar, scope: :spree)

# bad
Spree.t(:bar, scope: [:city])

# good
I18n.t(:bar, scope: [:spree, :city])

# bad
Spree.t(:bar, scope: [:city], email: email)

# good
I18n.t(:bar, scope: [:spree, :city], email: email)

# bad
Spree.t('bar', scope: 'admin.city')

# good
I18n.t('bar', scope: 'spree.admin.city')
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/22](https://github.com/solidusio/rubocop-solidus/issues/22)
