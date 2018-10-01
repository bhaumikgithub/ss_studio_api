class ContactsController < ApplicationController
  include ProfileCompleteHelper
  # Callabcks
  before_action :fetch_contact, only: [ :destroy, :update ]
  require 'open-uri'

  # GET  /contacts
  def index
    all_contacts_josn
  end

  # GET /contacts/import
  def import
    ImportGoogleContacts.new(params[:access_token], current_resource_owner).call
    all_contacts_josn
  end

  # POST  /contacts
  def create
    @contact = current_resource_owner.contacts.create!(resource_params)
    if @contact.present?  && !current_resource_owner.profile_completeness.contact_details
      next_task = next_task('contact_details')
      current_resource_owner.profile_completeness.update(contact_details: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    @contact.photo.update_user(current_resource_owner)
    json_response({
      success: true,
      data: {
        contact: single_record_serializer.new(@contact, serializer: Contacts::ContactAttributesSerializer),
      }
    }, 201)
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy!
    json_response({success: true, message: "contact destroy successfully.", data: { :contacts => @contact }}, 200)
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
    }, 201)
  end

  private
  def resource_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :status, :user_id, photo_attributes: [:id, :image, :_destroy] )
  end

  def fetch_contact
    @contact = current_resource_owner.contacts.find(params[:id])
  end

  def all_contacts_josn
    contacts = CommonService.get_contacts(current_resource_owner, params)
    json_response({
      success: true,
      data: {
        contacts: array_serializer.new(contacts, serializer: Contacts::ContactAttributesSerializer, style: "thumb"),
      },
      meta: meta_attributes(contacts)
    }, 200)
  end
end
