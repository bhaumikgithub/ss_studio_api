class AlbumRecipients::AlbumRecipientsAttributesSerializer < ActiveModel::Serializer
  attributes :id
  has_many :contact, serializer: AlbumRecipients::ContactsAttributesSerializer
end
