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
require 'inherited_resources'
require 'friendly_id'
require 'has_scope'
require 'sbdevcore'

module Sbdevcore
  class Engine < Rails::Engine
    engine_name "sbdevcore"

    rake_tasks do
      load "tasks/sbdevcore.rake"
    end

    config.action_mailer.perform_deliveries = !Rails.env.production?
    config.action_mailer.raise_delivery_errors = Rails.env.production?
  end
end