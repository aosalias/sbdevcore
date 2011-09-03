require 'rails'
require 'rubygems'
require 'tinymce-rails'
require 'prioritizable'
require 'devise'
require 'paperclip'
require 'haml'
require 'sitemap_generator'
require "hpricot"
require "simple_form"
require "client_side_validations"
require 'pg'
require 'formalize-rails'
require 'will_paginate'
require 'aws/s3'
require 'aasm'
require 'inherited_resources'
require 'friendly_id'
require 'sbdevcore'

module Sbdevcore
  class Engine < Rails::Engine
    engine_name "sbdevcore"

#    initializer 'sbdevcore.load_app_config', :before => :load_config_initializers do |app|
#      raw_config = File.read(Rails.root.join("config", "app_config.yml"))
#      app.class::APP_CONFIG = (YAML.load(raw_config)[Rails.env].merge YAML.load(raw_config)['shared']).symbolize_keys
#    end


    rake_tasks do
      load "tasks/sbdevcore.rake"
    end

    config.action_mailer.perform_deliveries = !Rails.env.production?
    config.action_mailer.raise_delivery_errors = Rails.env.production?
  end
end