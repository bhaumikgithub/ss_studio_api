class AlbumRecipientMailer < ApplicationMailer
  default from: "info@techplussoftware.com"

  def share_public_album_to_recipient_mail(album, album_recipient)
    @album = album
    @album_recipient = album_recipient
    @email_add = album_recipient.contact.email
    mail(to: @email_add, subject: "Share Album")
  end
  
  def share_private_album_to_recipient_mail(album, album_recipient)
    @album = album
    @album_recipient = album_recipient
    @album_passcode = album.passcode
    @email_add = album_recipient.contact.email
    mail(to: @email_add , subject: "Share Album")
  end

end
