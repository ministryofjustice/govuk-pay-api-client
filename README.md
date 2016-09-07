[![CircleCI](https://circleci.com/gh/ministryofjustice/govuk-pay-api-client.svg?style=svg&circle-token=7fcc2b811dde84109b6615aa4e7b6ed89350ea53)](https://circleci.com/gh/ministryofjustice/govuk-pay-api-client)

# GovukPayApiClient

A simple client to integrate with the Govuk Pay payment gateway.

## Usage

### Create Payment

```ruby
GovukPayApiClient::CreatePayment.call(<fee object>, <url to return to>)
```

The first argument is a fee object that must repond to `#description`
(text), `#reference` (string), and `#amount` (integer, in pence). The
second object is a url string that tell the Govuk Pay gateway where to
return the user after a successful payment.  Both are required.

`GovukPayApiClient::RequiresFeeObject` will be raised if a fee object is
not supplied.

`GovukPayApiClient::RequiresReturnUrl` will be raised if a return url is
not supplied.

### Get Status

```ruby
GovukPayApiClient::GetStatus.call(<fee object>)
```

Requires a fee object that must respond to `#govpay_payment_id`, which
should return an id that is valid on the Govuk Pay gateway.

It returns an object with the method `#status` for a successful calls.
Unsuccessful calls raise errors in the 400 to 599 status range and will
therefore raise `GovukPayApiClient::Unavailable` errors.

`GovukPayApiClient::RequiresFeeObject` will be raised if a fee object is
not supplied.

### Errors

If any `GovukPayApiClient` post or get request returns a status in the
400 to 599 range, the client will raise
`GovukPayApiClient::Unavailable`.  It will also raise
`GovukPayApiClient::Unavailable` if the connection times out or is
otherwise unavailable.


## Examples

See the dummy Rails app in `/spec/dummy` for examples of how the gem might
be used in a production environment.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'govuk-pay-api-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install govuk-pay-api-client

## Testing

Run `bundle rake` in the gem source directory for a full set of specs,
mutation tests and rubocop checks.

### Shared examples

The gem can install a set of shared examples in your app that will stub
a sensible set of API calls using Excon’s stubbing functionality. To
install these, install the gem, make sure you have the `spec/support`
subdirectory then run:

```ruby
bundle exec rake govuk_pay_api_client:install_shared_examples
```

This will install `spec/support/shared_examples_for_govpay.rb`.

Lastly, add these lines to `spec/rails_helper`:

```ruby
  config.before(:all) do
    Excon.defaults[:mock] = true
  end

  config.after(:each) do
    Excon.stubs.clear
  end
```

## Contributing

Fork, then clone the repo:

```bash
git clone git@github.com:your-username/govuk-pay-api-client.git
```

Make sure the tests pass:

```bash
bundle
bundle db:setup
bundle exec rake
```

Make your change. Add specs for your change. Make the specs pass:

```bash
bundle exec rake
```

Push to your fork and [submit a pull request][pr].

[pr]: https://github.com/ministryofjustice/govuk-pay-api-client/compare

Some things that will increase the chance that your pull request is
accepted:

* Write specs.
* Make sure you don’t have any mutants (part of total test suite).
* Write a [good commit message][commit].

[commit]: https://github.com/alphagov/styleguides/blob/master/git.md

## License
Released under the [MIT License](http://opensource.org/licenses/MIT).
Copyright (c) 2015-2016 Ministry of Justice.
