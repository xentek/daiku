# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class Honeybadger
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app
        class_option :'honeybadger-private-key', desc: "Honeybadger Private API Key"
        class_option :'honeybadger-public-key', desc: "Honeybadger Private API Key"

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def bootrb
          insert_into_file "#{app}/lib/boot.rb", "require File.join($app_root, 'config/honeybadger')\n", after: "#errors\n"
        end

        def config
          template('_templates/honeybadger.rb.tt', "#{app}/config/honeybadger.rb")
        end

        def dotenv
          honeybadger_private_key = options.fetch(:'honeybadger-private-key') { '' }
          honeybadger_public_key = options.fetch(:'honeybadger-public-key') { '' }
          append_to_file "#{app}/.env", "HONEYBADGER_PRIVATE_KEY=#{honeybadger_private_key}"
          append_to_file "#{app}/.env", "HONEYBADGER_PUBLIC_KEY=#{honeybadger_public_key}"
        end

        def gemfile
          insert_into_file "#{app}/Gemfile", "gem 'honeybadger'\n", after: "gem 'escape_utils'\n"
        end

        def rackup
          insert_into_file "#{app}/config.ru", "use Honeybadger::Rack::ErrorNotifier\n", after: "# middleware stack\n"
        end
      end
    end
  end
end
