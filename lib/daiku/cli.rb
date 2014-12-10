# encoding: utf-8

require 'thor'

module Daiku
  class CLI < ::Thor
    include ::Thor::Actions
    class_option :version, type: :boolean

    def self.source_root
      File.expand_path('../', __FILE__)
    end

    desc "new APP", "Generate a new application with daiku"
    method_option :port, required: true, aliases: '-p', type: :numeric, desc: 'Port this app should run on locally.'
    method_option :ruby, default: '2.1.5', desc: 'Specify the version of ruby this project should use.'
    method_option :node, default: 'v0.10.33', desc: 'Specify the version of node this project should use (for grunt, etc).'
    method_option :assets, aliases: '-a', desc: 'Choose the assets workflow this project uses.', enum: Daiku::Plugins.plugin_names('assets')
    method_option :errors, aliases: '-e', desc: 'Choose the error reporting lib this project uses.', enum: Daiku::Plugins.plugin_names('errors')
    method_option :jobs, aliases: '-j', desc: 'Choose the background jobs lib this project uses.', enum: Daiku::Plugins.plugin_names('jobs')
    method_option :models, aliases: '-m', desc: 'Choose the data modeling lib this project uses.', enum: Daiku::Plugins.plugin_names('models')
    method_option :monitors, aliases: '-M', desc: 'Choose the monitoring lib this project uses.', enum: Daiku::Plugins.plugin_names('monitors')
    method_option :vcr, type: :boolean, desc: "Include `vcr` in this project's BDD stack?", default: false
    method_option :sql, type: :boolean, desc: "SQL or No-SQL? If SQL, assumes postgresql", default: true
    def new(app)
      @app    = app
      @port   = options[:port]
      @ruby   = options[:ruby]
      @node   = options[:node]
      @models = options[:models]
      @assets = options[:assets]
      @jobs   = options[:jobs]

      # do the dew
      say "Generating #{app} app..."
      directory('_app', app)
      chmod("#{app}/bin/console", 'a+x')

      if @assets
        invoke plugins[@assets][:class].cli, [@app], options
      end

      if @errors
        invoke plugins[@errors][:class].cli, [@app], options
      end

      if @jobs
        invoke plugins[@jobs][:class].cli, [@app], options
      end

      if @models
        invoke plugins[@models][:class].cli, [@app], options
      end

      if @monitors
        invoke plugins[@monitors][:class].cli, [@app], options
      end

      if options[:sql]
        invoke plugins['database-sql'][:class].cli, [@app], options
      else
        say_status 'skipped', "--no-sql option is not supported yet", :yellow
      end

      if options[:vcr]
        invoke plugins['vcr'][:class].cli, [@app], options
      end

      say "Done!"
    end

    desc "version", "Show the daiku version"
    def version
      say "Daiku v#{Daiku::VERSION}"
    end
    default_task :version

    no_tasks do
      def plugins
        Daiku::Plugins.register_plugins
      end
    end
  end
end
