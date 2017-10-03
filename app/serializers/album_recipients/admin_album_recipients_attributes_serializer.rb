class AlbumRecipients::AdminAlbumRecipientsAttributesSerializer < ActiveModel::Serializer
  attributes :id, :custom_message, :minimum_photo_selection, :allow_comments
  belongs_to :contact, serializer: AlbumRecipients::ContactsAttributesSerializer
end