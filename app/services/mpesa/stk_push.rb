module Mpesa
  class StkPush
    attr_reader :amount, :phone_number

    ResponseObject = Struct.new(:success?, :body, :code, keyword_init: true)

    def initialize(amount, phone_number)
      @amount = amount
      @phone_number = phone_number
    end

    def simulate
      RestClient::Request.new(request_params).execute do |response, _request|
        case response.code
        when 500
          ResponseObject.new(success?: false, body: JSON.parse(response.to_str), code: response.code)
        when 400
          ResponseObject.new(success?: false, body: JSON.parse(response.to_str), code: response.code)
        when 200
          ResponseObject.new(success?: true, body: JSON.parse(response.to_str), code: response.code)
        else
          raise "Invalid response #{response.to_str} received."
        end
      end
    end

    private

    def request_params
      {
        method: :post,
        url: credentials.stk_push_url,
        payload: payload,
        headers: headers
      }
    end

    def payload
      {
        'BusinessShortCode': credentials.business_short_code,
        'Password': generate_password,
        'Timestamp': timestamp,
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': amount,
        'PartyA': credentials.phone_number,
        'PartyB': credentials.business_short_code,
        'PhoneNumber': phone_number.delete('+'),
        'CallBackURL': "#{credentials.callback_url}/api/v1/results",
        'AccountReference': 'Test',
        'TransactionDesc': 'Test'
      }.to_json
    end

    def generate_password
      Base64.encode64("#{credentials.business_short_code}#{credentials.pass_key}#{timestamp}").delete("\n")
    end

    def credentials
      @credentials ||= Rails.application.credentials.mpesa
    end

    def timestamp
      @timestamp ||= Time.current.strftime('%Y%m%d%H%M%S')
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{Mpesa::AccessToken.generate}"
      }
    end
  end
end
