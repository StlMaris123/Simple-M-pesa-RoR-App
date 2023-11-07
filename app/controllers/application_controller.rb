# frozen_string_literal: true

class ApplicationController < ActionController::API
  include TokenAuthenticable

  def render_unprocessable_entity(model)
    render_error(:unprocessable_entity, model)
  end

  def bad_params(error)
    render status: :bad_request,
           json: {
             error: {
               status: 400,
               name: 'Invalid Params',
               message: error
             }
           }
  end

  def respond_with_not_found
    resource = controller_name.classify.constantize.new(id: params[:id])
    resource.errors.add(:id, 'resource not found')
    render_error(:not_found, resource)
  end

  def render_error(status, resource = nil)
    render status: status,
           json: resource,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
