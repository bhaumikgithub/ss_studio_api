# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  around_action :handle_exceptions

  private

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
end
