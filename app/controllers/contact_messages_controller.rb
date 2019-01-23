class ContactMessagesController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  include InheritAction

  # POST /contact_messages
  def create
    ContactMessage.captcha = params[:contact_message][:captcha]
    @user = User.get_user(params[:user])
    if @user
      @admin_email = @user.contact_detail.email
    else
      @admin_email = "info@techplussoftware.com"
    end
    unless params[:contact_message][:from].present?
      @contact_message = ContactMessage.create!(resource_params)
      ContactMailer.delay.contact_message_mail(@contact_message,@admin_email)
      json_response({success: true, message: "contact message sent successfully.", data: { :contact_messages => @contact_message }}, 201)
    else
      @contact_message = ContactMessage.new(resource_params)
      if @contact_message.save
        ContactMailer.delay.contact_message_mail(@contact_message,@admin_email)
        $success = true
      else
        $errors = @contact_message.errors.full_messages.join("<br>")
      end
      redirect_to contact_detail_path(user: params[:user])
    end
  end

  private
  
  def resource_params
    params.require(:contact_message).permit(:name, :email, :phone, :message)
  end

end