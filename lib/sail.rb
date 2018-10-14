# frozen_string_literal: true

require 'sail/engine'
require 'sail/constant_collection'
require 'sail/configuration'
require 'sail/value_cast'
require 'true_class'
require 'false_class'

module Sail
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
