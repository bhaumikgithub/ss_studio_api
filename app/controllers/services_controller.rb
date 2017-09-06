class ServicesController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :active_services ]

  def active_services
    @active_services = Service.where(status: "active")
    json_response({
      success: true,
      data: {
        active_services: array_serializer.new(@active_services, serializer: Services::ServiceAttributesSerializer),
      }
    }, 200)
  end
end