class AlbumRecipients::AlbumRecipientsAttributesSerializer < ActiveModel::Serializer
  attributes :id, :custom_message
  belongs_to :contact, serializer: AlbumRecipients::ContactsAttributesSerializer
  belongs_to :album, key: "album", serializer: AlbumRecipients::AlbumsAttributesSerializer
end
