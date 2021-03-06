require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UltimateBlogProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.session_store :cookie_store, expire_after: 2.hours

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Rails.configuration.front_end_origin
        resource '*', headers: :any, methods: [:get, :post]
      end
    end

    # Settings in config/environments/*
    # take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
