class UserMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default from: 'support@ss_studio.com'
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

  def contact_us(resource, contact_params)
    @resource = resource
    @contact_params = contact_params
    mail(to: @resource.email, subject: 'Contact Us')
  end
end