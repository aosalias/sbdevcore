require 'rails'
require 'rubygems'
require 'aws/s3'
require 'paperclip'
require 'devise'
require 'will_paginate'
require 'tiny_mce'
require 'haml'
require 'aasm'
require 'pg'
require 'core'

module Core
  class Engine < Rails::Engine
    engine_name "Core"

    rake_tasks do
      load "tasks/core.rake"
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
end