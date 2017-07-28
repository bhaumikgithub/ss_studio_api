# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  around_action :handle_exceptions
  before_action :doorkeeper_authorize!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def doorkeeper_unauthorized_render_options(error: nil)
    # puts "===error====#{error.inspect}========="
    { json: { error: "You are not authorized." } }
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :status, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)

    if current_resource_owner.present?
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    else
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
  end

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  # Catch exception and return JSON-formatted error
  # rubocop:disable MethodLength
  def handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound => e
      @status = 404
      @message = 'Record not found'
    rescue ActiveRecord::RecordInvalid => e
      render_unprocessable_entity_response(e.record) && return
    rescue ArgumentError => e
      @status = 400
    rescue StandardError => e
      @status = 500
    end
    json_response({ success: false, message: @message || e.class.to_s, errors: [{ detail: e.message }] }, @status) unless e.class == NilClass
  end

  def render_unprocessable_entity_response(resource)
    json_response({
                    success: false,
                    message: 'Validation Failed',
                    errors: ValidationErrorsSerializer.new(resource).serialize
                  }, 422)
  end

  def render_success_response(resources = {}, status = 200)
    json_response({
                    success: true,
                    data: resources
                  }, status)
  end

  def meta_attributes(collection, extra_meta = {})
    if collection.nil?
      []
    else
      {
        pagination: {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      }.merge(extra_meta)
    end
  end

  def json_response(options = {}, status = 500)
    render json: JsonResponse.new(options), status: status
  end

  def array_serializer
    ActiveModel::Serializer::CollectionSerializer
  end

  def single_record_serializer
    ActiveModelSerializers::SerializableResource
  end
end
