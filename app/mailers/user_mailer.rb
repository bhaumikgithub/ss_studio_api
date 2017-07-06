class UserMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'users/mailer'

  def user_confirmation(resource)
    @resource = resource
    mail(to: @resource.email, subject: 'Account create successfully.')
  end

  # Overrides same inside Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    super
  end

  # Overrides same inside Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    super
  end

  # Overrides same inside Devise::Mailer
  def unlock_instructions(record, token, opts={})
    super
  end
end