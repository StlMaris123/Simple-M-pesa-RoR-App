# app/services/mpesa/access_token.rb
module Mpesa
  class AccessToken
    class << self
      def generate
        response = RestClient::Request.execute(request_params)

        return 'Unable to generate access token' unless response.code == 200

        body = JSON.parse(response.body, symbolize_names: true)
        body[:access_token]
      end

      private

      def credentials
        @credentials ||= Rails.application.credentials.mpesa
      end

      def request_params
        {
          url: credentials.oauth_url,
          method: :get,
          headers:headers
        }
      end

      def authorization_token
        Base64.strict_encode64("#{credentials.consumer_key}:#{credentials.consumer_secret}")
      end

      def headers
        {
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{authorization_token}"
        }
      end
    end
  end
end
