# frozen_string_literal: true

# Application Mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'info@sagargadani.com'
  layout 'mailer'
end
