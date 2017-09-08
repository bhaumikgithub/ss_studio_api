class ContactMailer < ApplicationMailer
  def contact_message_mail(contact_message)
    @contact_message = contact_message
    mail(from: contact_message.email, to: ["info@techplussoftware.com", "photo.gadani51@gmail.com"] , subject: "Contact Messages")
  end
end
