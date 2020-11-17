# frozen_string_literal: true

require 'omniauth-oauth2'
require 'json/jwt'

module OmniAuth
  module Strategies
    class Trusona < OmniAuth::Strategies::OAuth2
      option :name, 'trusona'
      option :scope, 'openid email profile'

      option :client_options,
             site: 'https://gateway.trusona.net',
             authorize_url: '/oidc',
             jwks_url: '/oidc/certs'

      option :authorize_options, %i[scope state]

      def request_phase
        redirect client.implicit.authorize_url({ redirect_uri: callback_url }.merge(authorize_params))
      end

      def authorize_params
        super.tap do |params|
          nonce = SecureRandom.hex(24)

          session['omniauth.nonce'] = nonce
          params[:nonce] = nonce
        end
      end

      def callback_phase
        super

        fail!(:nonce_mismatch) if access_token.nonce != session.delete('omniauth.nonce')
      end

      def build_access_token
        decoded = JSON::JWT.decode(request.params['id_token'], jwks_set)

        OmniAuth::Trusona::IdToken.new(decoded)
      end

      def jwks_set
        response = client.request(:get, jwks_url)
        jwks = JSON.parse(response.body)

        JSON::JWK::Set.new(jwks)
      end

      def jwks_url
        client.connection.build_url(options[:client_options][:jwks_url])
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      uid do
        access_token.uid
      end

      info do
        access_token.info
      end

      extra do
        access_token.extra
      end
    end
  end
end
