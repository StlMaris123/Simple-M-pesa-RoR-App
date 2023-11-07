# frozen_string_literal: true

module TokenAuthenticable
  extend ActiveSupport::Concern

  NotAuthorizedException = Class.new(StandardError)

  included do
    before_action :authenticate_user
    rescue_from NotAuthorizedException, with: :unauthorized_request
  end

  private

  def authenticate_user
    @current_user = Authentication::DecodeAuthenticateService.call(request.headers).result
    Current.user = @current_user
    raise NotAuthorizedException unless @current_user
  end

  def unauthorized_request
    render json: {
      error: { status: 401, name: 'Not Authorized', message: 'Invalid Credentials!!' }
    }, status: :unauthorized
  end
end
