# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Messages', type: :request do
  require 'rails_helper'

  let(:user) { FactoryBot.create(:user) }

  # before { sign_in user }

  describe 'POST #create' do
    context 'with a valid immediate message' do
      it 'sends the message immediately and returns success' do
        post :create

        expect(response).to have_http_status(:created)
        expect(response.body).to include('Message sent immediately')
      end
    end

    context 'with a valid scheduled message' do
      it 'schedules the message for the future and returns success' do
        scheduled_at = 1.day.from_now.iso8601

        post :create, params: { scheduled_at: }

        expect(response).to have_http_status(:created)
        expect(response.body).to include('Message scheduled successfully')
      end
    end

    context 'with missing parameters' do
      it 'returns an unprocessable entity response' do
        post :create

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Validation failed') # Adjust this based on your error response
      end
    end

    context 'when Twilio error occurs' do
      it 'returns an unprocessable entity response with error message' do
        allow(MessageSender).to receive(:perform_async).and_raise(Twilio::REST::RestError.new('Twilio error message'))

        post :create

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Twilio error message')
      end
    end
  end
end
