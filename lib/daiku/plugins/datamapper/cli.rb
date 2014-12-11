# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class Datamapper
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def bootrb
          insert_into_file "#{app}/lib/boot.rb", :after => "#models\n" do
            <<-DMREQ.strip_heredoc
              require File.join($app_root, 'config/datamapper')
              # require models here
              DataMapper.finalize
            DMREQ
          end
        end

        def config
          template('_templates/datamapper.rb.tt', "#{app}/config/datamapper.rb")
        end

        def gemfile
          content = <<-DMGEMS.strip_heredoc
            group :datamapper do
              gem 'dm-aspects'
              gem 'dm-aggregates'
              gem 'dm-core'
              gem 'dm-migrations'
              gem 'dm-pager'
              gem 'dm-postgres-adapter'
              gem 'dm-postgres-types'
              gem 'dm-timestamps'
              gem 'dm-transactions'
              gem 'dm-validations'
            end
          DMGEMS
          append_to_file "#{app}/Gemfile", content
        end

        def rake
          template "_templates/datamapper.rake.tt", "#{app}/lib/tasks/datamapper.rake"
        end

        def readme
          append_to_file "#{app}/README.md" do
            <<-SREADME.strip_heredoc
              # Migrate It

                  # create postgres extensions, optional but recommended (run once)
                  bundle exec rake db:datamapper:hstore
                  bundle exec rake db:datamapper:postgis
                  bundle exec rake db:datamapper:postgis_topology
                  bundle exec rake db:datamapper:postgis_tiger_geocoder

                  # upgrade database (safe migration)
                  bundle exec rake db:datamapper:upgrade

                  # migrate database (drops and recreates tables - danger!)
                  bundle exec rake db:datamapper:migrate
            SREADME
          end
        end
      end
    end
  end
end
