# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Messages', type: :request do
 
    describe 'POST #create' do

      context 'successful message' do
        it 'returns a success response' do
          user = FactoryBot.create(:user)
          sign_in user
          post :create
          expect(response).to have_http_status(:created)
        end
      end

      context 'with missing message parameter' do
        it 'returns an unprocessable entity response' do
          post :create
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
