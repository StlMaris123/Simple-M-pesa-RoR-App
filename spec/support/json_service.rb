# frozen_string_literal: true

module JSONService
  module Helpers
    def json_response
      @json_response ||= JSON.parse(response.body)
    end

    def attributes
      @attributes ||= JSON.parse(response.body).dig('data', 'attributes')
    end

    def relationships
      @relationships ||= JSON.parse(response.body).dig('data', 'relationships')
    end

    def data_attributes
      @data_attributes ||=
        JSON
        .parse(response.body)['data']
        .map { |payload| payload['attributes'] }
    end
  end
end
