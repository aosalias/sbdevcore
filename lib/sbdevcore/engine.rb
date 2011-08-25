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
require 'pg'
require 'formalize-rails'
require 'sbdevcore'

module Sbdevcore
  class Engine < Rails::Engine
    engine_name "sbdevcore"

    rake_tasks do
      load "tasks/sbdevcore.rake"
    end

    config.action_mailer.perform_deliveries = !Rails.env.production?
    config.action_mailer.raise_delivery_errors = Rails.env.production?

    initializer 'sbdevcore.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Sbdevcore::ApplicationControllerExtensions
      end
    end

    initializer 'sbdevcore.view_helpers' do |app|
      ActionView::Base.send :include, ViewHelpers
    end
  end

  module Routes
    def self.draw(map)
      map.instance_exec do
        devise_for :admins

        resources :contacts

        resources :photos
        resources :videos
        resources :downloadables
        resources :texts
        resources :galleries

        resources :indices do
          resources :photos
          resources :videos
          resources :downloadables
          resources :texts
          resource :gallery
        end
      end
    end
  end

  module ViewHelpers
    def custom_form_for(object, *args, &block)
      options = args.extract_options!
      simple_form_for(object, *(args << options.merge(:builder => CustomFormBuilder)), &block)
    end
    class CustomFormBuilder < SimpleForm::FormBuilder
      def input(attribute_name, options = {}, &block)
        column     = find_attribute_column(attribute_name)
        input_type = default_input_type(attribute_name, column, options)
        if options.has_key?(:input_html)
          options[:input_html].merge!(:class => input_type)
        else
          options[:input_html] = {:class => input_type}
        end
        super
      end
    end
  end
end