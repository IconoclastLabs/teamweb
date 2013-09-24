require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Teamweb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    #For heroku
    config.assets.initialize_on_precompile = false

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql
    

    # Added 'components' to load Bower components to the asset pipeline
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components', 'font-awesome', 'scss')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components', 'font-awesome', 'font')
    # config.assets.paths << Rails.root.join('vendor', 'assets', 'components', 'bootstrap', 'dist', 'fonts')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    # Precompile additional assets
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
