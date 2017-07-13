class ContactMailer < ApplicationMailer
  default from: "from@example.com"

  def contact_message_mail(contact_message)
    @contact_message = contact_message
    mail(from: contact_message.email, to: "info@techplussoftware.com" , subject: "Contact Messages")
  end
end
