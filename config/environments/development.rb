# frozen_string_literal: true
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Set developemtnt local timezone
  config.time_zone = "Kolkata"

  # Show full error reports.
  config.consider_all_requests_local = true

  config.action_controller.asset_host = "http://localhost:4000"

  config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.smtp_settings = {
  #   :address              => "smtp.elasticemail.com",
  #   :port                 => 2525,
  #   :user_name            => "d52a5793-8b82-41df-a2d2-341de3da2e45",
  #   :password             => "d52a5793-8b82-41df-a2d2-341de3da2e45",
  #   :authentication       => 'login',
  #   :domain               => 'afterclix.com',
  #   :enable_starttls_auto => true
  # }
  config.action_mailer.default_url_options = { host: 'localhost', port: 4000 }
  config.action_mailer.perform_deliveries = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  # config.paperclip_defaults = {
  #   storage: :s3,
  #   s3_region: ENV['AWS_S3_REGION'],
  #   s3_credentials: {
  #     s3_host_name: ENV['AWS_S3_HOST_NAME'],
  #     bucket: ENV['AWS_S3_BUCKET_PROD'],
  #     access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  #     secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  #     },
  #   :s3_protocol => :https
  #   }


  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
