class ServicesController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :active_services ]

  def active_services
    @active_services = Service.where(status: "active")
    render_success_response({ :active_services => @active_services}, 200)
  end
end