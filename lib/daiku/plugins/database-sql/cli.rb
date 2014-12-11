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
          template '_templates/db_helper.rb.tt', "#{app}/spec/db_helper.rb"
        end

        def gemfile
          insert_into_file "#{app}/Gemfile", "  gem 'database_cleaner'\n", after: "group :test do\n"
        end

        def rake
          template "_templates/db.rake.tt", "#{app}/lib/tasks/db.rake"
        end

        def readme
          content = <<-DBREADME
          ## Sync It

          _Instructions on how to sync the database..._

          `production` to `staging`

          Sync DB:

              # instructions go here...

          ---

          ### `production` to `development`

          Sync DB:

              # instructions go here...

          ---

          ### `staging` to `development`

          Sync DB:

              # instructions go here...


          DBREADME
          append_to_file "#{app}/README.md", content
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
