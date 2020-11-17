# frozen_string_literal: true

module OmniAuth
  module Trusona
    class IdToken
      def initialize(jwt)
        @jwt = jwt
      end

      def uid
        @jwt[:sub]
      end

      def info
        info_hash
      end

      def extra
        {
          'raw_info' => @jwt.to_hash
        }
      end

      def nonce
        @jwt[:nonce]
      end

      def token
        @jwt.to_s
      end

      def expires?
        false
      end

      def expired?
        false
      end

      def refresh!; end

      private

      def info_hash
        return @info_hash if @info_hash

        @info_hash = { 'email' => @jwt[:email] }

        @info_hash['first_name'] = @jwt[:given_name] if @jwt[:given_name]
        @info_hash['last_name'] = @jwt[:family_name] if @jwt[:family_name]
        @info_hash['nickname'] = @jwt[:nickname] if @jwt[:nickname]

        @info_hash
      end
    end
  end
end
