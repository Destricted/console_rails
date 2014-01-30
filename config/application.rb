require File.expand_path('../boot', __FILE__)

require 'rails/all'

require "net/http"
require 'faye'
require 'eventmachine'
require 'childprocess'

Bundler.require(:default, Rails.env)

module Apptest
  class Application < Rails::Application
  end
end
