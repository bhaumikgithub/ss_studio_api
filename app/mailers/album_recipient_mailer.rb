class AlbumRecipientMailer < ApplicationMailer
  default from: "from@example.com"

  def share_album_to_recipient_mail(contact, album_recipient, album)
    @contact = contact
    @album_recipient = album_recipient
    @album = album
    @album_passcode = @album.passcode
    mail(from: "info@techplussoftware.com", to: contact.email , subject: "Share Album")
  end
end
