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
    params[:album_recipient][:email].each do |email|
      @contact = Contact.find_or_create_by!(email: email) # email find if not find from contact then its create first
      album_recipients << @album.album_recipients.create!(album_recipient_params.merge(contact_id: @contact.id).permit!)
    end
    @email_add = (params[:album_recipient][:email]).flatten
    if @album.is_private == true
      @mail_response = AlbumRecipientMailer.share_private_album_to_recipient_mail( @contact, @album, album_recipients.first, @email_add).deliver
    else
      @mail_response = AlbumRecipientMailer.share_public_album_to_recipient_mail(@contact, @album, album_recipients.first, @email_add).deliver
    end

    @album_recipient = @album.album_recipients.where("ID IN (?)", album_recipients)
    @album_recipient.update(is_email_sent: true)
    json_response({success: true, message: "Album share successfully.", data: {album_recipients: @album_recipient}}, 201)
  end

  #POST /albums/:album_id/album_recipients/:id/resend
  def resend
    album_recipients = @album.album_recipients.find_by(id: params[:id])
    @contact = album_recipients.contact
    @email_add = @contact.email

    if @album.is_private == true
      @mail_response = AlbumRecipientMailer.share_private_album_to_recipient_mail( @contact, @album, album_recipients, @email_add).deliver
    else
      @mail_response = AlbumRecipientMailer.share_public_album_to_recipient_mail(@contact, @album, album_recipients, @email_add).deliver
    end

    @album_recipient = @album.album_recipients.where("ID IN (?)", album_recipients)
    json_response({success: true, message: "Album share successfully.", data: {album_recipients: @album_recipient}}, 201)
  end

  private

  def fetch_album
    @album = current_resource_owner.albums.find(params[:album_id])
  end

  def album_recipient_params
    params.require(:album_recipient).permit(:custom_message, :album_id )
  end
end