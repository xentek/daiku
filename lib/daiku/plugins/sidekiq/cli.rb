# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class Sidekiq
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def bootrb
          insert_into_file "#{app}/lib/boot.rb", "require File.join($app_root, 'config/sidekiq')\n", after: "# jobs\n"
        end

        def config
          template('_templates/sidekiq.rb.tt', "#{app}/config/sidekiq.rb")
          empty_directory("#{app}/lib/jobs")
          create_file("#{app}/lib/jobs/.gitkeep", "")
        end

        def dotenv
          append_to_file "#{app}/.env", "SIDEKIQ_USERNAME=#{app}\n"
          append_to_file "#{app}/.env", "SIDEKIQ_PASSWORD=#{app}\n"
        end

        def gemfile
          insert_into_file "#{app}/Gemfile", "gem 'sidekiq'\n", after: "gem 'puma', require: false\n"
        end

        def procfile
          append_to_file "#{app}/Procfile", "sidekiq: bundle exec sidekiq -q default -r ./lib/boot.rb\n"
        end

        def rackup
          content = <<-SKMW.strip_heredoc
            require 'sidekiq/web'
            map '/sidekiq' do
              Sidekiq::Web.use Rack::Auth::Basic do |username, password|
              username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
            end
            run Sidekiq::Web
          SKMW
          append_to_file "#{app}/config.ru", content
        end
      end
    end
  end
end
