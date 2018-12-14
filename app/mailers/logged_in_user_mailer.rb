class LoggedInUserMailer < ApplicationMailer
  def login_user_instruction_mail(email, phone, first_name, last_name)
    @email = email
    @phone = phone
    @first_name = first_name
    @last_name = last_name
    mail(from: "bhaumikgithub@gmail.com", to: "info@afterclix.com" , subject: "Logged in user information")
  end
end