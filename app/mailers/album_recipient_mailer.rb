class AlbumRecipientMailer < ApplicationMailer
  default from: "info@techplussoftware.com"

  def share_public_album_to_recipient_mail(contacts, album, album_recipients, email_add)
    @contacts = contacts
    @album = album
    @album_recipients = album_recipients
    @email_add = email_add
    mail(to: @email_add, subject: "Share Album")
  end
  
  def share_private_album_to_recipient_mail(contacts, album, album_recipients, email_add)
    @contacts = contacts
    @album = album
    @album_recipients = album_recipients
    @album_passcode = album.passcode
    @email_add = email_add
    mail(to: @email_add , subject: "Share Album")
  end

end
