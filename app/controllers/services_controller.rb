class ServicesController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :service_details ]
  before_action :fetch_service, only: [:update]

  # GET  /services/active_services
  def active_services
    @active_services = current_resource_owner.services.where(status: "active")
    json_response({
      success: true,
      data: {
        active_services: array_serializer.new(@active_services, serializer: Services::ServiceAttributesSerializer),
      }
    }, 200)
  end

  # PATCH  /services/:id
  def update
    @service.update_attributes!(resource_params)
    json_response({
      success: true,
      message: "Service updated successfully.",
      data: {
        service: single_record_serializer.new(@service, serializer: Services::ServiceAttributesSerializer),
      }
    }, 201)
  end

  # GET  /services/service_details
  def service_details
    @active_services = User.get_user(params[:user]).services.where(status: "active")
    json_response({
      success: true,
      data: {
        active_services: array_serializer.new(@active_services, serializer: Services::ServiceAttributesSerializer),
      }
    }, 200)
  end

  # POST /services
  def create
    @resource = current_resource_owner.services.create!(resource_params)
    render_success_response({ service: @resource }, 201) if @resource
  end

  private

  def fetch_service
    @service = current_resource_owner.services.find(params[:id])
  end
end