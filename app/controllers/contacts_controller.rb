class ContactsController < ApplicationController
  
  # Callabcks
  before_action :fetch_contact, only: [ :destroy, :update ]

  # GET  /contacts
  def index
    @contacts = current_resource_owner.contacts
    json_response({
      success: true,
      data: {
        contacts: array_serializer.new(@contacts, serializer: Contacts::ContactAttributesSerializer),
      },
      meta: meta_attributes(@albums)
    }, 200)
  end

  # POST  /contacts
  def create
    @contact = current_resource_owner.contacts.create!(resource_params)
    @contact.photo.update_user(current_resource_owner)
    json_response({
      success: true,
      data: {
        contact: single_record_serializer.new(@contact, serializer: Contacts::ContactAttributesSerializer),
      }
    }, 200)
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy!
    json_response({success: true, message: "contact destroy successfully.", data: { :contacts => @contact }}, 201)
  end

  # PATCH  /contacts/:id
  def update
    @contact.update_attributes!(resource_params)
    @contact.photo.update_user(current_resource_owner)
    json_response({
      success: true,
      data: {
        contact: single_record_serializer.new(@contact, serializer: Contacts::ContactAttributesSerializer),
      }
    }, 200)
  end

  private
  def resource_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :status, :user_id, photo_attributes: [:id, :image, :_destroy] )
  end

  def fetch_contact
    @contact = current_resource_owner.contacts.find(params[:id])
  end
end
