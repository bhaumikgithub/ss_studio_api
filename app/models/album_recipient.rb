class AlbumRecipient < ApplicationRecord
  belongs_to :album
  belongs_to :contact

  def shared_album_link(album)
    if album.is_private == true
      @mail_response = AlbumRecipientMailer.share_private_album_to_recipient_mail(album, self).deliver
    else
      @mail_response = AlbumRecipientMailer.share_public_album_to_recipient_mail(album, self).deliver
    end
  end
end
