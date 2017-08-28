class AlbumRecipients::ContactsAttributesSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email
end