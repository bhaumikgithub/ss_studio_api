class AlbumRecipientsController < ApplicationController
  include InheritAction

  # POST /album_recipients
  def create
    album_recipients = []
    params[:album_recipient][:email].each do |email|
      @contact = Contact.find_or_create_by!(email: email) # email find if not find from contact then its create first
      album_recipients << AlbumRecipient.create!(album_recipient_params.merge(contact_id: @contact.id).permit!)
    end
    json_response({success: true, message: "Album share successfully.", data: {album_recipients: album_recipients}}, 201)
  end

  private
  def album_recipient_params
    params.require(:album_recipient).permit(:is_email_sent, :custom_message, :album_id )
  end
end