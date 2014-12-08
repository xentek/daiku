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
      end
    end
  end
end