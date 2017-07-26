class ContactDetailsController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [ :show ]
  before_action :fetch_contact_detail, only: [ :show, :update ]

  # GET /contact_details
  def show
    render_success_response({ :contact_detail => @contact_detail}, 200)
  end

  #PUT /contact_details
  def update
    @contact_detail.update_attributes!(contact_detail_param)
    render_success_response({ :contact_detail => @contact_detail}, 201)
  end

  private

  def contact_detail_param
    params.require(:contact_detail).permit(:address, :email, :phone)
  end

  def fetch_contact_detail
    @contact_detail = ContactDetail.first
  end
end
