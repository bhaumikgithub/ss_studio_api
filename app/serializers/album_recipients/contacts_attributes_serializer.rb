class AlbumRecipients::ContactsAttributesSerializer < ActiveModel::Serializer
  attributes :full_name, :email
end