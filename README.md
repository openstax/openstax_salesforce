# OpenStax::Salesforce

[![Gem Version](https://badge.fury.io/rb/openstax_salesforce.svg)](http://badge.fury.io/rb/fine_print)
[![Build Status](https://travis-ci.org/openstax/openstax_salesforce.svg?branch=master)](https://travis-ci.org/openstax/openstax_salesforce)
[![Code Climate](https://codeclimate.com/github/openstax/openstax_salesforce/badges/gpa.svg)](https://codeclimate.com/github/openstax/openstax_salesforce)

OpenStax::Salesforce is a Rails engine used by OpenStax projects to communicate with the OpenStax Salesforce instance.

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

Then execute the following command to copy the necessary migration and the initializer to your application:

```sh
$ rake openstax_salesforce:install
```

And then migrate your database:

```sh
$ rake db:migrate
```

Also add OpenStax::Salesforce to your application's routes:

```rb
mount OpenStax::Salesforce::Engine => "/salesforce"
```

And provide a link on your site for administrators to access the engine.

```erb
<%= link_to 'Salesforce Setup', openstax_salesforce_path %>
```

## Configuration

After installation, the initializer for OpenStax::Salesforce will be located under
`config/initializers/openstax_salesforce.rb`. Make sure to configure it to suit
your needs. Pay particular attention to `authenticate_admin_proc`,
as you will be unable to access the setup pages until this proc is setup to return
`true` for your admins.

## Testing

From the gem's main folder, run `bundle install`,
`bundle exec rake db:migrate` and then
`bundle exec rake` to run all the specs.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create specs for your feature
4. Ensure that all specs pass
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new pull request
