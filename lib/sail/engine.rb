# frozen_string_literal: true

module Sail
  # Engine
  # Defines initializers and
  # after initialize hooks
  class Engine < ::Rails::Engine
    require "jquery-rails" if Rails::VERSION::MAJOR < 5
    isolate_namespace Sail

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "sail.assets.precompile" do |app|
      app.config.assets.precompile += %w[sail/refresh.png]
    end

    initializer "sail" do
      unless Sail.configuration.dashboard_auth_lambda.nil?
        to_prepare do
          Sail::SettingsController.before_action(*Sail.configuration.dashboard_auth_lambda)
        end
      end
    end

    config.after_initialize do
      Sail::Setting.load_defaults unless Rails.env.test?
    end

    private

    def to_prepare
      klass = defined?(ActiveSupport::Reloader) ? ActiveSupport::Reloader : ActionDispatch::Reloader
      klass.to_prepare(&Proc.new)
    end
  end
end
