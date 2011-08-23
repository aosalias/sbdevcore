module Sbdevcore
  module ApplicationControllerExtensions
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.before_filter :get_index
    end
    module InstanceMethods
      def get_index
        @index = Index.find_by_name(controller_name)
      end
    end
  end
end
