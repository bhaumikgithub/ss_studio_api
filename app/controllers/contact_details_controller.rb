class ContactDetailsController < ApplicationController
  before_action :fetch_contact_detail, only: [ :update ]

  def update
    @contact_detail.update_attributes!(contact_detail_params)
    json_response({success: true, message: "contact detail update successfully.", data: { :contact_details => @contact_detail }}, 201)
  end   

  private
  def contact_detail_params
    params.require(:contact_details).permit(:address, :email, :phone, :user_id)
  end

  def fetch_contact_detail
    @contact_detail = current_resource_owner.contact_details.find(params[:id])
  end
end
