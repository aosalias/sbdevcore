module Core
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :app_name, :type => :string

      def database
        copy_file "devise.rb", "config/initializers/devise.rb"
        template  'database.yml', 'config/database.yml', :force => true
        rake "db:drop:all"
        rake "db:create"
      end

      def remove_bs
        remove_file 'public/index.html'
        remove_file 'public/images/rails.png'
        remove_file 'app/views/layouts/application.html.erb'
        remove_file 'app/assets/stylesheets/application.css'
      end

      def migrations
        rake "railties:install:migrations"
        rake "db:migrate"
      end

      def set_routes
        route "Core::Routes.draw(self)"
        statics = <<-STR
Index.find_all_by_name(APP_CONFIG[:static_pages]).each do |page|
    match page.name => "indices#show", :id => page.id, :as => page.name.to_sym
  end
  root :to => "indices#show", :id => (Index.find_by_name('home').id rescue 1)
        STR
        route statics
      end

      def seeds
        copy_file "load_app_config.rb", "config/initializers/load_app_config.rb"
        copy_file "app_config.yml", "config/app_config.yml"
        copy_file "application.html.haml", "app/views/layouts/application.html.haml"
        copy_file "seeds.rb", "db/seeds.rb", :force => true
        copy_file "application.sass", "app/assets/stylesheets/application.sass", :force => true
        copy_file "sass.sass", "app/assets/stylesheets/sass.sass", :force => true
        copy_file "tiny_mce.yml", "config/tiny_mce.yml", :force => true
        copy_file "s3.yml", "config/s3.yml", :force => true
        copy_file "mailer_setup.rb", "config/s3.yml", :force => true
        inject_into_file "app/assets/javascripts/application.js", "//= require core\n  ", :before => "//= require_tree ."
      end

      private
      def db_file_name
        app_name.downcase.underscore
      end
    end
  end
end

