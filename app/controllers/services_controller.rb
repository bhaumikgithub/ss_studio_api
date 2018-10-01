class ServicesController < ApplicationController
  include InheritAction
  include ProfileCompleteHelper
  skip_before_action :doorkeeper_authorize!, only: [ :service_details ]
  before_action :fetch_service, only: [:update]

  # GET  /services/active_services
  def active_services
    @active_services = current_resource_owner.services.where(status: "active").order('updated_at DESC')
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
    @active_services = User.get_user(params[:user]).services.where(status: "active").order('updated_at DESC')
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
    if @resource.present? && !current_resource_owner.profile_completeness.service
      next_task = next_task('service')
      current_resource_owner.profile_completeness.update(service: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    render_success_response({ service: @resource }, 201) if @resource
  end

  private

  def fetch_service
    @service = current_resource_owner.services.find(params[:id])
  end
end