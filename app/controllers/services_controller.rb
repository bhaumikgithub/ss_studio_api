class ServicesController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :active_services ]
  before_action :fetch_service, only: [:update]

  def active_services
    @active_services = Service.where(status: "active")
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

  private

  def fetch_service
    @service = Service.find(params[:id])
  end
end