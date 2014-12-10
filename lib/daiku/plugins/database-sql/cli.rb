# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class DatabaseSql
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app
        class_option :'db-name', desc: 'development database name'
        class_option :'db-url',  desc: 'development database connection url'

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def dotenv
          dbname  = options.fetch(:'db-url') { app }
          dburl = options.fetch(:'db-name') { "postgres://localhost/#{app}" }
          append_to_file "#{app}/.env", "DATABASE_NAME=#{dbname}\n"
          append_to_file "#{app}/.env", "DATABASE_URL=#{dburl}\n"
        end

        def config
          template('_templates/db_helper.rb.tt', "#{app}/spec/db_helper.rb")
        end

        def gemfile
          insert_into_file "#{app}/Gemfile", "  gem 'database_cleaner'\n", after: "group :test do\n"
        end

        def spechelper
          insert_into_file "#{app}/spec/spec_helper.rb", "DatabaseCleaner.strategy = :truncation\n", after: "Bundler.setup(:test)\n"
        end

        def travisyml
          insert_into_file "#{app}/.travis.yml", "  - postgresql\n", after: "services:\n"
          insert_into_file "#{app}/.travis.yml", "  postgresql: 9.3\n", after: "addons:\n"
          insert_into_file "#{app}/.travis.yml", %Q(  - psql -c 'create database "#{app}_test";' -U postgres\n), after: "before_script:\n"
        end
      end
    end
  end
end
