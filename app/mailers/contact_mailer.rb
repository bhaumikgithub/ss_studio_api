class ContactMailer < ApplicationMailer
  def contact_message_mail(contact_message, admin_email)
    @contact_message = contact_message
    mail(from: contact_message.email, to: [admin_email] , subject: "Contact Messages")
  end
end
