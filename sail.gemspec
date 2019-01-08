# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)
require "sail/version"

# rubocop:disable BlockLength
Gem::Specification.new do |s|
  s.name        = "sail"
  s.version     = Sail::VERSION
  s.authors     = ["Vinicius Stock"].freeze
  s.email       = ["vinicius.stock@outlook.com"].freeze
  s.homepage    = "https://github.com/vinistock/sail"
  s.summary     = "Sail is a lightweight Rails engine that brings an admin panel for managing configuration settings on a live Rails app."
  s.description = "Sail is a lightweight Rails engine that brings an admin panel for managing configuration settings on a live Rails app."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.post_install_message = <<~MESSAGE
    **************************************************************************
    Sail 2.0.0!

    If you're upgrading from older versions check breaking changes in release
    notes https://github.com/vinistock/sail/releases/tag/2.0.0
    **************************************************************************
  MESSAGE

  s.add_dependency "fugit"
  s.add_dependency "jquery-rails"
  s.add_dependency "rails"
  s.add_dependency "sass-rails"

  s.add_development_dependency "bundler"
  s.add_development_dependency "byebug"
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-selenium"
  s.add_development_dependency "codeclimate-test-reporter", "~> 1.0"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "rack-mini-profiler"
  s.add_development_dependency "rails_best_practices"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "simplecov", "~> 0.16.1"
  s.add_development_dependency "sqlite3"
end
# rubocop:enable BlockLength
