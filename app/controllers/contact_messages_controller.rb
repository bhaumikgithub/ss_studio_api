class ContactMessagesController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  include InheritAction

  # POST /contact_messages
  def create
    ContactMessage.captcha = params[:contact_message][:captcha]
    @user = User.get_user(params[:user])
    if @user
      @admin_email = @user.try(:contact_detail).try(:email).present? ? @user.contact_detail.email : @user.try(:email)
    else
      @admin_email = "info@techplussoftware.com"
    end
    @contact_message = ContactMessage.create!(resource_params)
    ContactMailer.delay.contact_message_mail(@contact_message,@admin_email)
    json_response({success: true, message: "contact message sent successfully.", data: { :contact_messages => @contact_message }}, 201)
  end

  private
  
  def resource_params
    params.require(:contact_message).permit(:name, :email, :phone, :message)
  end

end