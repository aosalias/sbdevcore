module Sbdevcore
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :app_name, :type => :string

      def remove_bs
        puts "foo\n\n\n"
        directory "config", "config", :force => true
        remove_file 'public/index.html'
        remove_file 'public/images/rails.png'
        remove_file 'app/views/layouts/application.html.erb'
        remove_file 'app/assets/stylesheets/application.css'
      end

      def database
        template  'database.yml', 'config/database.yml', :force => true
        rake "db:drop:all"
        rake "db:create"
      end

      def migrations
        rake "sbdevcore:install:migrations"
        rake "db:migrate"
      end

      def set_routes
        route "Sbdevcore::Routes.draw(self)"
        statics = <<-STR
  root :to => "indices#show", :id => ('home')
  match "(:id)" => "indices#show"
        STR
        route statics
      end

      def seeds
        copy_file "application.scss", "app/assets/stylesheets/application.scss", :force => true
        copy_file "sass.scss", "app/assets/stylesheets/sass.scss", :force => true
        directory "application", "app/views/application"
        directory "layouts", "app/views/layouts"
        inject_into_file "app/assets/javascripts/application.js", "//= require sbdevcore\n", :before => "//= require_tree ."

        dev_mailer = <<-OPTS

ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.raise_delivery_errors = true
        OPTS
        inject_into_file "config/environments/development.rb", dev_mailer, :after => "Application.configure do"

        prod_mailer = <<-OPTS

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
        OPTS
        inject_into_file "config/environments/production.rb", prod_mailer, :after => "Application.configure do"
        gsub_file "config/environments/production.rb", /"X-Sendfile"/, "nil" 
      end

      def git
        run "git init ."
        copy_file ".gitignore", ".gitignore", :force => true
        run "git add ."
        run "git commit -m 'first commit'"
      end

      private
      def db_file_name
        app_name.downcase.underscore
      end
    end
  end
end

