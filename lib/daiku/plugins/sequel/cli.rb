# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class Sequel
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app
        class_option :'sequel-postgis', type: :boolean, desc: 'Enable postgis extension via Sequel migration', default: true

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def bootrb
          insert_into_file "#{app}/lib/boot.rb", :after => "#models\n" do
            <<-DMREQ.strip_heredoc
              require File.join($app_root, 'config/sequel')
              # require models here
            DMREQ
          end
        end

        def config
          template('_templates/sequel.rb.tt', "#{app}/config/sequel.rb")
        end

        def db_migrations
          empty_directory("#{app}/db")
          empty_directory("#{app}/db/migrations")
          create_file("#{app}/db/migrations/.gitkeep", "")
          template('_templates/001_create_extension_hstore.rb.tt', "#{app}/app/db/migrations/001_create_extension_hstore.rb")
          if options[:'sequel-postgis']
            template('_templates/002_create_extension_postgis.rb.tt', "#{app}/app/db/migrations/002_create_extension_postgis.rb")
          end
        end

        def gemfile
          content = <<-SGEMS.strip_heredoc
            group :sequel do
              gem 'pg'
              gem 'sequel'
              gem 'sequel_pg'
            end
          SGEMS
          append_to_file "#{app}/Gemfile", content
        end

        def rake
          template "_templates/sequel.rake.tt", "#{app}/lib/tasks/sequel.rake"
        end

        def readme
          append_to_file "#{app}/README.md" do
            <<-SREADME.strip_heredoc
              # Migrate It

                  # migrate to latest version
                  bundle exec rake db:sequel:migrate

                  # migrate up to specific version
                  bundle exec rake db:sequel:migrate[001]
            SREADME
          end
        end
      end
    end
  end
end
