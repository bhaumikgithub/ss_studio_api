class AlbumRecipients::AlbumRecipientsAttributesSerializer < ActiveModel::Serializer
  attributes :id, :custom_message, :minimum_photo_selection, :allow_comments, :view_album_url, :admin_album_recipients
  belongs_to :contact, serializer: AlbumRecipients::ContactsAttributesSerializer
  belongs_to :album, key: "album", serializer: AlbumRecipients::AlbumsAttributesSerializer
  def view_album_url
    ENV['FRONT_URL'] + object.album.user.first_name + "/shared_album/" + object.album.slug + "?token=" + object.contact.token
  end
  def admin_album_recipients
    object.album.album_recipients.where("recipient_type=(?)",1).last
  end
end
