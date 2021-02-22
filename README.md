# OmniAuth Trusona

An OmniAuth strategy for Trusona. This strategy uses the OIDC Implicit flow to integrate Trusona with OmniAuth

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-trusona'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install omniauth-trusona


## Usage

To use this OmniAuth Strategy, you will first need to create an OIDC Integration with Trusona. This will provide you with a `client_id` that can be used in the usage examples below.

## Creating an OIDC Integration with Trusona

1. Login into our [Dashboard](https://dashboard.trusona.com)
1. On the left hand side under Integrations client Generic OIDC
1. Click the Create OpenID Connection Integration
1. Provide a meaningful to you name for the Integartion
1. For Client Redirect Host, enter the domain name where your service is hosted. You can provide more than one host separated by commas.
1. Click Save
1. The `client_id` will be shown in the list of OIDC Integrations. Save this for use with the Strategy.

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :trusona, client_id: ENV['TRUSONA_CLIENT_ID']
end
```

## Basic Rails Usage
In `config/initializers/trusona.rb`:
```ruby
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :trusona, client_id: ENV['TRUSONA_CLIENT_ID']
  end
```

## Basic Devise Usage
In `/config/initializers/devise.rb`:
```ruby
  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  config.omniauth :trusona,
  {
    client_id: ENV['TRUSONA_CLIENT_ID']
  }
```

In `app/models/user.rb`:
```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:trusona]
```

## Development
The redirect url must be an HTTPS url.  For local development, you can try running this to set up an ssl proxy.

```
npm install -g local-ssl-proxy

local-ssl-proxy --source 3001 --target 3000
```

Then run your rails app as normal.  In the browser, use `https://localhost:3001`.

## SSL

OIDC requires SSL for communications which means if you are running this project locally, you will need to server over https.  We accomplish that with the following local ssl proxy.  See the Development notes above


## CLIENT_ID

Add a .env file to the root with 

`TRUSONA_CLIENT_ID=<YOUR CLIENT ID>`

See above for details on obtaining a client id

## Rails Example
We've provided a Rails Example that uses the gem at `/examples/rails-devise`.  Please note that application.rb has the following configuration:

```
config.force_ssl = true
config.action_dispatch.cookies_same_site_protection = :none
```
