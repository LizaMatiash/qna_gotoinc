require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.active_job.queue_adapter = :sidekiq
    # config.eager_load_paths += %W(#{config.root}/app/indices/answers_index.rb)
    # config.eager_load_paths += %W(#{config.root}/app/indices/comments_index.rb)
    # config.eager_load_paths += %W(#{config.root}/app/indices/questions_index.rb)
    # config.eager_load_paths += %W(#{config.root}/app/indices/users_index.rb)
    config.autoload_paths += %W(#{config.root}/app/indices/)
    # config.autoload_paths += %W(#{config.root}/app/serializers/)
    # config.autoload_paths += %W(#{config.root}/app/indices/answers_index.rb)
    # byebug
  end
end
