class LoggedInUserMailer < ApplicationMailer
  def login_user_instruction_mail(email, phone, first_name, last_name)
    @email = email
    @phone = phone
    @first_name = first_name
    @last_name = last_name
    mail(from: "info@afterclix.com", to: @email , subject: "Logged in user instruction")
  end
end