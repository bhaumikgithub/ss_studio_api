class AlbumRecipientsController < ApplicationController
  include InheritAction

  before_action :fetch_album, only: [:create]
  
  # POST /albums/:album_id/album_recipients
  def create
    album_recipients = []
    params[:album_recipient][:email].each do |email|
      @contact = Contact.find_or_create_by!(email: email) # email find if not find from contact then its create first
      album_recipients << @album.album_recipients.create!(album_recipient_params.merge(contact_id: @contact.id).permit!)
      AlbumRecipientMailer.share_album_to_recipient_mail(album_recipients).deliver
    end
    json_response({success: true, message: "Album share successfully.", data: {album_recipients: album_recipients}}, 201)
  end

  private

  def fetch_album
    @album = current_resource_owner.albums.find(params[:album_id])
  end

  def album_recipient_params
    params.require(:album_recipient).permit(:is_email_sent, :custom_message, :album_id )
  end
end