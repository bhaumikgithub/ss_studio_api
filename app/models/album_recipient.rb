class AlbumRecipient < ApplicationRecord
  belongs_to :album
  belongs_to :contact

  enum recipient_type: { guest: 0, admin: 1 }

  def shared_album_link(album,admin_email)
    if album.is_private == true
      @mail_response = AlbumRecipientMailer.delay.share_private_album_to_recipient_mail(album,admin_email, self)
    else
      @mail_response = AlbumRecipientMailer.delay.share_public_album_to_recipient_mail(album,admin_email, self)
    end
  end
end
