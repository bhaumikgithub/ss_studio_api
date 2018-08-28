class SuperAdminUserMailer < ApplicationMailer
  def new_user_instruction_mail(email, password, admin_email)
    @email = email
    @password = password
    mail(from: admin_email, to: @email , subject: "Registerd User Instruction")
  end
end
