# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class Newrelic
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def gemfile
          insert_into_file "#{app}/Gemfile", "  gem 'newrelic_rpm'\n", after: "group :production, :staging do\n"
        end
      end
    end
  end
end
