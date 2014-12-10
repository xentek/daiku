# encoding: utf-8

require 'thor'

module Daiku
  class Plugins
    class Grunt
      class CLI < ::Thor::Group
        include ::Thor::Actions
        argument :app

        def self.source_root
          File.expand_path('../', __FILE__)
        end

        def config
          template '_templates/.bowerrc', "#{app}/.bowerrc"
          template '_templates/bower.json.tt', "#{app}/bower.json"
          template '_templates/Gruntfile.coffee.tt', "#{app}/Gruntfile.coffee"
          template '_templates/package.json.tt', "#{app}/package.json"
          directory '_config', "#{app}/.grunt"
        end

        def layout
          insert_into_file "#{app}/views/layout.slim", %Q(    link rel="stylesheet" type="text/css" href="/assets/app.css"\n), before: "  body\n"
          insert_into_file "#{app}/views/layout.slim", %Q(    script src="/assets/html5shiv.js"\n), before: "  body\n"
          insert_into_file "#{app}/views/layout.slim", %Q(    script src="/assets/app.js"\n), after: "    == yield\n"
        end
      end
    end
  end
end
