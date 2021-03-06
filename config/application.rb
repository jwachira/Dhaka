require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Bundler.require(:default, Rails.env) if defined?(Bundler)
# Bundler.require *Rails.groups(:assets) if defined?(Bundler)
Bundler.require(:default, :assets, Rails.env) if defined?(Bundler)

module Dhaka
  class Application < Rails::Application
    # Load in Compass's files for use with SASS
    config.sass.load_paths << "#{Gem.loaded_specs['compass'].full_gem_path}/frameworks/compass/stylesheets"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/app/observers)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    config.active_record.observers = :user_observer, :listing_observer, :permalink_observer # :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable the asset pipeline
    config.assets.enabled     = true
    config.assets.precompile += %w( analytics.js categories.js dhaka.js listings.js users.js )

    # Configure generator defaults
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false
    end
  end
end