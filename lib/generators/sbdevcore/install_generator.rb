module Sbdevcore
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :app_name, :type => :string

      def remove_bs
        remove_file 'public/index.html'
        remove_file 'public/images/rails.png'
        remove_file 'app/views/layouts/application.html.erb'
        remove_file 'app/assets/stylesheets/application.css'
      end

      def database
        directory "config", "config", :force => true
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
Index.find_all_by_name(APP_CONFIG[:static_pages]).each do |page|
    match page.name => "indices#show", :id => page.id, :as => page.name.to_sym
  end rescue true
  root :to => "indices#show", :id => (Index.find_by_name('home').id rescue 1)
        STR
        route statics
      end

      def seeds
        copy_file "seeds.rb", "db/seeds.rb", :force => true

        copy_file "application.scss", "app/assets/stylesheets/application.scss", :force => true
        copy_file "sass.scss", "app/assets/stylesheets/sass.scss", :force => true
        directory "application", "app/views/application"

        copy_file "new_contact.html.erb", "app/views/contacts/new.html.erb", :force => true
        inject_into_file "app/assets/javascripts/application.js", "//= require sbdevcore\n", :before => "//= require_tree ."

        dev_mailer = <<-OPTS

ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.raise_delivery_errors = true
        OPTS
        inject_into_file "config/environments/development.rb", dev_mailer, :after => "Tester::Application.configure do"

        prod_mailer = <<-OPTS

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
        OPTS
        inject_into_file "config/environments/production.rb", prod_mailer, :after => "Tester::Application.configure do"
        gsub_file "config/environments/production.rb", /"X-Sendfile"/, "nil" 
      end

      def git
        run "git init ."
        copy_file ".gitignore", ".gitignore", :force => true
        copy_file "git_config", ".git/config", :force => true
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

