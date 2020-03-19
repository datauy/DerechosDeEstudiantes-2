require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DerechosEstuduantiles
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es]
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    #config.exceptions_app = self.routes
  end
end
