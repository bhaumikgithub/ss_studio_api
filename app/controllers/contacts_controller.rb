class ContactsController < ApplicationController
  # Callabcks
  before_action :fetch_contact, only: [ :destroy, :update ]
  require 'open-uri'

  # GET  /contacts
  def index
    response = ContactService.new(current_resource_owner, params ).call

    json_response({
      success: true,
      data: response[:data],
      meta: meta_attributes(response[:contacts])
    }, 200)
  end

  # GET /contacts/import
  def import
    contacts_josn = JSON.parse(open("https://www.google.com/m8/feeds/contacts/default/full?max-results=50&alt=json", "Authorization" =>  "Bearer #{params[:access_token]}", "GData-Version" => "3.0").read)

    contacts = contacts_josn["feed"]["entry"].collect{ |p|
      {
        first_name: (p["gd$name"]["gd$givenName"]["$t"] unless p["gd$name"].nil?),
        last_name:  (p["gd$name"]["gd$familyName"]["$t"] unless p["gd$name"].nil? || p["gd$name"]["gd$familyName"].nil?),
        email: (p["gd$email"][0]['address'] unless p["gd$email"].nil?),
        phone: (p["gd$phoneNumber"][0]["$t"] unless p["gd$phoneNumber"].nil?)
      }
    }
    contacts.each do |contact|
      begin
        new_contact = current_resource_owner.contacts.new(contact)
        new_contact.save(validate: false)
      rescue StandardError => e
        puts "===#{e.inspect}======"
      end
    end
    render json: {response: contacts}
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
end
