OmniAuth ICOS ID
==============

This gem contains the ICOS ID strategy for OmniAuth.

For more information about ICOS ID: http://icosid.com

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-icos'
```

Then `bundle install`.


## Basic Usage

```ruby

Rails.application.config.middleware.use OmniAuth::Builder do
   provider :icos, ENV['ICOS_CLIENT_ID'], ENV['ICOS_CLIENT_SECRET']
end

```

You should use the provider name which is 'icos'.


After you have the gem running and the configuration is done, you can get to the follow url to log the user in:

	http://localhost:3000/users/auth/icos


