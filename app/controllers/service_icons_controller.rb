class ServiceIconsController < ApplicationController
  include InheritAction

  # GET /service_icons
  def index
    @service_icons = ServiceIcon.where(status: "active")
    render_success_response({ :service_icons => @service_icons },200)
  end

end
