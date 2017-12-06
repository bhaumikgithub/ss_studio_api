class AlbumRecipients::AdminAlbumRecipientsAttributesSerializer < ActiveModel::Serializer
  attributes :id, :custom_message, :minimum_photo_selection, :allow_comments, :view_album_url
  belongs_to :contact, serializer: AlbumRecipients::ContactsAttributesSerializer

  def view_album_url
    ENV['FRONT_URL'] + "shared_album/" + object.album.slug + "?token=" + object.contact.token
  end
end