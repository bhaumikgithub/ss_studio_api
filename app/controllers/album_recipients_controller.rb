class AlbumRecipientsController < ApplicationController
  include InheritAction

  before_action :fetch_album, only: [:create, :resend]

  # GET /albums/:album_id/album_recipients
  def index
    @album_recipients = current_resource_owner.albums.find_by(id: params[:album_id]).album_recipients
    json_response({
      success: true,
      data: {
        album_recipients: array_serializer.new(@album_recipients, serializer: AlbumRecipients::AlbumRecipientsAttributesSerializer),
      }
    }, 200)
  end
  
  # POST /albums/:album_id/album_recipients
  def create
    album_recipients = []
    params[:album_recipient][:emails].each do |email|
      @contact = Contact.find_or_create_contact(email,current_resource_owner)
      album_recipients << @album.album_recipients.create!(album_recipient_params.merge(contact_id: @contact.id).permit!)
    end
    album_recipients.each do |album_recipient|
      album_recipient.shared_album_link(@album)
    end

    @album_recipient = @album.album_recipients.where("ID IN (?)", album_recipients)
    @album_recipient.update(is_email_sent: true)
    json_response({
      success: true,
      message: "Album share successfully.",
      data: {
        album_recipients: array_serializer.new(@album_recipient, serializer: AlbumRecipients::AlbumRecipientsAttributesSerializer),
      }
    }, 201)
    # json_response({success: true, message: "Album share successfully.", data: {album_recipients: @album_recipient}}, 201)
  end

  #POST /albums/:album_id/album_recipients/:id/resend
  def resend
    album_recipient = @album.album_recipients.find_by(id: params[:id])
    album_recipient.shared_album_link(@album)
    json_response({
      success: true,
      data: {
        album_recipient: single_record_serializer.new(album_recipient, serializer: AlbumRecipients::AlbumRecipientsAttributesSerializer),
      }
    }, 201)
    # json_response({success: true, message: "Album share successfully.", data: {album_recipients: album_recipient}}, 201)
  end

  private

  def fetch_album
    @album = current_resource_owner.albums.find(params[:album_id])
  end

  def album_recipient_params
    params.require(:album_recipient).permit(:custom_message, :album_id )
  end
end