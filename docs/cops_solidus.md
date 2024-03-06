---
layout: departments
title: List of available Solidus cops
---

## Solidus/ClassEvalDecorator

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.1 | - | -

Solidus suggests a decorator module instead of `class_eval` when overriding some features.
This cop finds any `class_eval` and asks to use a decorator module instead.
More info: https://guides.solidus.io/customization/customizing-the-core.

### Examples

```ruby
# bad
SpreeClass.class_eval do
  # your code here
end

# good
module Spree
  module SpreeClassDecorator
    # your code here
  end

  Spree::SpreeClass.prepend self
end
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/21](https://github.com/solidusio/rubocop-solidus/issues/21)

## Solidus/DiscountedAmountDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.3 | - | 2.4

This cop finds .discounted_amount occurrences and suggest using .total_before_tax instead.

### Examples

```ruby
# bad
line_item.discounted_amount

# good
line_item.total_before_tax
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/31](https://github.com/solidusio/rubocop-solidus/issues/31)

## Solidus/ExistingCardIdDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.2 | - | 2.2

This cop finds existing_card_id occurrences and suggest using wallet_payment_source_id instead.

### Examples

```ruby
# bad
{
  name: payment_method.name,
  existing_card_id: payment_source.id
}

# good
{
  name: payment_method.name,
  wallet_payment_source_id: payment_source.wallet.wallet_payment_sources.first.id
}
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/60](https://github.com/solidusio/rubocop-solidus/issues/60)

## Solidus/ReimbursementHookDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.1 | - | 2.11

This cop finds reimbursement_success_hooks and reimbursement_failed_hooks calls and
asks to remove them and subscribe to reimbursement_reimbursed event instead.

### Examples

```ruby
# bad
reimbursement_success_hooks.each { |h| h.call self }
reimbursement_failed_hooks.each { |h| h.call self }

# good
```
```ruby
# bad
reimbursement_success_hooks.any?
reimbursement_failed_hooks.any?

# good
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/27](https://github.com/solidusio/rubocop-solidus/issues/27)

## Solidus/SpreeCalculatorFreeShippingDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.1 | - | -

This cop finds Spree::Calculator::FreeShipping calls.
This cop is needed as they have been deprecated in future version.

### Examples

```ruby
# bad
Spree::Calculator::FreeShipping

# good
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/29](https://github.com/solidusio/rubocop-solidus/issues/29)

## Solidus/SpreeCalculatorPercentPerItemDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1 | - | -

This cop finds Spree::Calculator::PercentPerItem calls.
This cop is needed as they have been deprecated in future version.

### Examples

```ruby
# bad
Spree::Calculator::PercentPerItem

# good
Spree::Calculator::PercentOnLineItem
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/29](https://github.com/solidusio/rubocop-solidus/issues/29)

## Solidus/SpreeCalculatorPriceSackDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.1 | - | -

This cop finds Spree::Calculator::PriceSack calls.
This cop is needed as they have been deprecated in future version.

### Examples

```ruby
# bad
Spree::Calculator::PriceSack

# good
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/29](https://github.com/solidusio/rubocop-solidus/issues/29)

## Solidus/SpreeDefaultAddressDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.3 | - | 2.11

This cop finds user.default_address or user.default_address and suggest
using user.ship_address or user.default_user_ship_address instead.

### Examples

```ruby
# bad
user.default_address
user.default_user_address

# good
user.ship_address
user.default_user_ship_address
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/61](https://github.com/solidusio/rubocop-solidus/issues/61)

## Solidus/SpreeDefaultCreditCardDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.1 | - | 2.2

This cop finds user.default_credit_card suggest using user.wallet.default_wallet_payment_source.

### Examples

```ruby
# bad
user.default_credit_card

# good
user.wallet.default_wallet_payment_source
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/33](https://github.com/solidusio/rubocop-solidus/issues/33)

## Solidus/SpreeGatewayBogusDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1 | - | 2.1

This cop finds Spree::Gateway::Bogus calls and replaces them with the Spree::PaymentMethod::BogusCreditCard.
This cop is needed as the Spree::Gateway::Bogus has been deprecated in future version.

### Examples

```ruby
# bad
Spree::Gateway::Bogus.new
Spree::Gateway::Bogus.create
Spree::Gateway::Bogus.create!

# good
Spree::PaymentMethod::BogusCreditCard.new
Spree::PaymentMethod::BogusCreditCard.create
Spree::PaymentMethod::BogusCreditCard.create!
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/26](https://github.com/solidusio/rubocop-solidus/issues/26)

## Solidus/SpreeIconDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1 | - | 2.3

This cop finds icon helper calls and suggest using solidus_icon.

### Examples

```ruby
# bad
helper.icon('example')

# good
helper.solidus_icon('example')
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/32](https://github.com/solidusio/rubocop-solidus/issues/32)

## Solidus/SpreeRefundCallPerform

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.1 | - | 2.11

This cop finds Spree::Refund.create(your: attributes) calls and
replaces them with the Spree::Refund.create(your: attributes, perform_after_create: false).perform! call.

### Examples

```ruby
# bad
Spree::Refund.create(your: attributes)

# good
Spree::Refund.create(your: attributes, perform_after_create: false).perform!
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/28](https://github.com/solidusio/rubocop-solidus/issues/28)

## Solidus/SpreeTDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.1 | - | -

This cop finds Spree.t method calls and replaces them with the I18n,t method call.
This cop is needed as the Spree.t version has been deprecated in future version.

### Examples

```ruby
# Without any parameters

# bad
Spree.t(:bar)

# good
I18n.t(:bar, scope: :spree)
```
```ruby
# With the scope parameter

# bad
Spree.t(:bar, scope: [:city])

# good
I18n.t(:bar, scope: [:spree, :city])
```
```ruby
# With the scope and other parameters

# bad
Spree.t(:bar, scope: [:city], email: email)

# good
I18n.t(:bar, scope: [:spree, :city], email: email)
```
```ruby
# With the scope parameter as a string

# bad
Spree.t('bar', scope: 'admin.city')

# good
I18n.t('bar', scope: 'spree.admin.city')
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/22](https://github.com/solidusio/rubocop-solidus/issues/22)

## Solidus/TaxCategoryDeprecated

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged | Required Solidus Version
--- | --- | --- | --- | --- | ---
Enabled | Yes | No | 0.3 | - | 2.2

This cop finds .tax_category occurrences and suggest using .tax_categories instead.

### Examples

```ruby
# bad
  model.tax_category = data

# good
  model.tax_categories = [data]
```

### References

* [https://github.com/solidusio/rubocop-solidus/issues/25](https://github.com/solidusio/rubocop-solidus/issues/25)
