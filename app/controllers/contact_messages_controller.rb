class ContactMessagesController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  include InheritAction

  # POST /contact_messages
  def create
    @contact_message = ContactMessage.create!(resource_params)
    ContactMailer.delay.contact_message_mail(@contact_message)
    
    json_response({success: true, message: "contact message sent successfully.", data: { :contact_messages => @contact_message }}, 201)
  end

  private
  
  def resource_params
    params.require(:contact_message).permit(:name, :email, :phone, :message)
  end

end