# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class Vcr
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def config
          template('_templates/vcr_helper.rb.tt', "#{app}/spec/vcr_helper.rb")
          empty_directory("#{app}/spec/_cassettes")
          create_file("#{app}/spec/_cassettes/.gitkeep", "")
        end

        def gemfile
          insert_into_file "#{app}/Gemfile", after: "  gem 'mocha', require: 'mocha/setup'\n" do
            "  gem 'vcr', require: false\n" +
            "  gem 'webmock', '< 1.12', require: false\n"
          end
        end
      end
    end
  end
end
