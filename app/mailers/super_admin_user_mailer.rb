class SuperAdminUserMailer < ApplicationMailer
  def new_user_instruction_mail(email, password, admin_email)
    @email = email
    @password = password
    mail(from: "info@afterclix.com", to: @email , subject: "Registerd User Instruction")
  end
end
