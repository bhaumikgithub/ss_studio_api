class AlbumRecipientsController < ApplicationController
  include InheritAction

  before_action :fetch_album, only: [:create, :resend, :get_admin_album_recipients, :reset_admin_recipients]
  before_action :fetch_admin_email, only: [:create, :resend]

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
    if params[:album_recipient][:ids].present?
      AlbumRecipient.where("ID IN (?)",params[:album_recipient][:ids]).destroy_all
    end
    album_recipient_ids = []
    params[:album_recipient][:emails].each do |email|
      @contact = Contact.create_contact(email,current_resource_owner)
      recipient = @album.album_recipients.create!(album_recipient_params.merge(contact_id: @contact.id).permit!)
      recipient.shared_album_link(@album, @admin_email)
      album_recipient_ids << recipient.id
    end

    @album_recipients = @album.album_recipients.where("ID IN (?)", album_recipient_ids)
    @album.Shared! unless @album.Submitted? && @album.Delivered?

    json_response({
      success: true,
      message: "Album share successfully.",
      data: {
        album_recipients: array_serializer.new(@album_recipients, serializer: AlbumRecipients::AlbumRecipientsAttributesSerializer),
      }
    }, 201)
  end

  #POST /albums/:album_id/album_recipients/:id/resend
  def resend
    album_recipient = @album.album_recipients.find_by(id: params[:id])
    album_recipient.shared_album_link(@album, @admin_email)
    json_response({success: true, message: "Album share successfully.", data: {album_recipients: album_recipient}}, 201)
  end

  # GET albums/:album_id/album_recipients/not_invited_contacts
  def not_invited_contacts
    recipient_emails = []
    @album_recipients = current_resource_owner.albums.find_by(id: params[:album_id]).album_recipients
    @not_invited_contacts = current_resource_owner.contacts.where.not(id: @album_recipients.pluck(:contact_id)).includes(:photo)

    json_response({
      success: true,
      data: {
        contacts: array_serializer.new(@not_invited_contacts, serializer: Contacts::ContactAttributesSerializer),
      }
    }, 200)
  end

  # GET   /albums/:album_id/album_recipients/get_admin_album_recipients
  def get_admin_album_recipients
    @album_recipients = @album.album_recipients.where("recipient_type=(?)",params[:type])
    json_response({
      success: true,
      data: {
        album_recipients: array_serializer.new(@album_recipients, serializer: AlbumRecipients::AdminAlbumRecipientsAttributesSerializer),
      }
    }, 200)
  end

  # DELETE /albums/:album_id/album_recipients/reset_admin_recipients
  def reset_admin_recipients
    @album.album_recipients.where(recipient_type: 'admin').destroy_all
    @album.update_attributes(delivery_status: "Shared")
    Comment.where(id: Album.last.photos.joins(:comment).select("comments.id as comment_id").map(&:comment_id)).delete_all
    @album.photos.where(is_selected: true).update_all(is_selected: false)
    render_success_response({success: true,
      data: {
        photos: array_serializer.new(@album.photos, serializer: Albums::PhotoAttributesSerializer)
      }}, 200)
  end

  private

  def fetch_album
    @album = current_resource_owner.albums.find(params[:album_id])
  end

  def fetch_admin_email
    @admin_email = ContactDetail.first.email
  end
  def album_recipient_params
    params.require(:album_recipient).permit(:custom_message, :minimum_photo_selection, :allow_comments, :recipient_type)
  end
end