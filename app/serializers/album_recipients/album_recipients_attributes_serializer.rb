class AlbumRecipients::AlbumRecipientsAttributesSerializer < ActiveModel::Serializer
  attributes :id, :custom_message, :minimum_photo_selection, :allow_comments, :admin_album_recipients
  belongs_to :contact, serializer: AlbumRecipients::ContactsAttributesSerializer
  belongs_to :album, key: "album", serializer: AlbumRecipients::AlbumsAttributesSerializer

  def admin_album_recipients
    object.album.album_recipients.where("recipient_type=(?)",1).last
  end
end
