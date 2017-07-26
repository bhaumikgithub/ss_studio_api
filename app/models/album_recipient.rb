class AlbumRecipient < ApplicationRecord
  belongs_to :album
  belongs_to :contact
end
