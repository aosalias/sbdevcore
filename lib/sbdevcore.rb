require "sbdevcore/version"
require "sbdevcore/engine"

module Sbdevcore

  module Routes
    def self.draw(map)
      map.instance_exec do
        devise_for :admins

        resources :contacts

        resources :photos
        resources :videos
        resources :downloadables
        resources :texts
        resources :galleries do
          resources :indices
        end

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