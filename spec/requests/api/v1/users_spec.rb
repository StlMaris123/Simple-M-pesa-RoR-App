# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /api/v1/users' do
    let!(:users) { FactoryBot.create_list(:user, 2) }
    let(:user_id) { users.first.id }

    before { get api_v1_users_path, headers: global_headers }

    it 'returns users' do
      expect(data_attributes).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/users/:id' do
    before { get api_v1_user_path(user.id), headers: global_headers }

    it 'returns a user' do
      expect(attributes).not_to be_empty
      expect(json_response['data']['id']).to eq(user.id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns status code 404' do
      get api_v1_user_path(id: 'not-found'), headers: global_headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/v1/users' do
    let(:user_params) { FactoryBot.attributes_for(:user) }

    it 'creates a user' do
      post api_v1_users_path, params: { user: user_params }, headers: global_headers
      expect(response).to have_http_status(:created)
      expect(attributes['email']).to eq(user_params[:email])
    end

    it 'returns status code 422' do
      post api_v1_users_path, params: { user: { email: '' } }, headers: global_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /api/v1/users/:id' do
    let(:user_params) { { user: { email: 'updated@user.com' } } }

    it 'updates a user' do
      put api_v1_user_path(user.id), params: user_params, headers: global_headers
      expect(response).to have_http_status(:ok)
      expect(attributes['email']).to eq(user_params[:user][:email])
    end

    it 'returns status code 422' do
      put api_v1_user_path(user.id), params: { user: { email: '' } }, headers: global_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    it 'deletes a user' do
      delete api_v1_user_path(user.id), headers: global_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
