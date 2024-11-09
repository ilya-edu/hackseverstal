require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LctApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.hosts << 'lct.localtest.me'
    config.hosts << 'lct-api.kovalev.team'
    config.debug_exception_response_format = :api
    config.time_zone = 'Europe/Moscow'
    # config.i18n.default_locale = :ru

    config.after_initialize do
      ActiveStorage::Current.host = ENV['active_storage_host']
    end
  end
end
