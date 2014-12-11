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
      end
    end
  end
end
