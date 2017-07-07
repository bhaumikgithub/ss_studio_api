class ContactsController < ApplicationController
  
  # Callabcks
  before_action :fetch_contact, only: [ :destroy, :update ]

  # GET  /contacts
  def index
    @contacts = current_resource_owner.contacts
    render_success_response({ :contacts => @contacts })
  end

  # POST  /contacts
  def create
    @contact = current_resource_owner.contacts.create!(resource_params)
    render_success_response({ :contacts => @contact }, 201)
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy!
    json_response({success: true, message: "contact destroy successfully.", data: { :contacts => @contact }}, 201)
  end

  # PATCH  /contacts/:id
  def update
    @contact.update_attributes!(resource_params)
    json_response({success: true, message: "contact update successfully.", data: { :contacts => @contact }}, 201)
  end

  private
  def resource_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :status, :user_id )
  end

  def fetch_contact
    @contact = current_resource_owner.contacts.find(params[:id])
  end
end
