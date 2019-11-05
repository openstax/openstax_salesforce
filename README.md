# OpenStax::Salesforce

[![Gem Version](https://badge.fury.io/rb/openstax_salesforce.svg)](http://badge.fury.io/rb/openstax_salesforce)
[![Build Status](https://travis-ci.org/openstax/openstax_salesforce.svg?branch=master)](https://travis-ci.org/openstax/openstax_salesforce)
[![Code Climate](https://codeclimate.com/github/openstax/openstax_salesforce/badges/gpa.svg)](https://codeclimate.com/github/openstax/openstax_salesforce)

OpenStax::Salesforce is a Rails engine used by OpenStax projects to communicate
with the OpenStax Salesforce instance.

## Installation

Add this line to your application's Gemfile:

```rb
gem 'openstax_salesforce'
```

And then execute:

```sh
$ bundle
```

Or install it yourself:

```sh
$ gem install openstax_salesforce
```

Then execute the following command to copy the necessary initializer to your application:

```sh
$ rake openstax_salesforce:install
```

## Configuration

After installation, the initializer for OpenStax::Salesforce will be located under
`config/initializers/openstax_salesforce.rb`. Make sure to configure it to suit your needs.

You will need the following information from Salesforce:
  - Your username (append .sandboxname if using a sandbox)
  - Your password
  - Your security token
  - Connected App's client key
  - Connected App's client secret
Enter all the above information in the initializer, secrets.yml or environment variables.

## Testing

From the gem's main folder, run `bundle install` and then `bundle exec rake` to run all the specs.

### Specs in Parent App

There's a helper you can include in your parent app's salesforce specs.
It isn't automatically required by this engine, so you have to do it manually in your spec:

```ruby
require 'openstax/salesforce/spec_helper'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create specs for your feature
4. Ensure that all specs pass
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new pull request
