class ContactMessagesController < ApplicationController
  include InheritAction

  def create
    @contact_message = ContactMessage.create!(resource_params)
    if @contact_message.save!
      ContactMailer.contact_message_mail(@contact_message).deliver
    end
    json_response({success: true, message: "contact message sent successfully.", data: { :contact_messages => @contact_message }}, 201)
  end

  private
  
  def resource_params
    params.require(:contact_message).permit(:name, :email, :phone, :message)
  end

end