# encoding: utf-8

require 'thor'

module Daiku
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../', __FILE__)
    end

    desc "new APP", "Generate a new application with daiku"
    method_option :port, required: true, aliases: '-p', type: :numeric, desc: 'Port this app should run on locally.'
    method_option :ruby_version, default: '2.1.2', desc: 'Specify the version of ruby this project should use.'
    method_option :models, default: 'datamapper', aliases: '-m', desc: 'Choose the data modeling tool this project uses.', enum: ['datamapper', 'none']
    method_option :assets, default: 'grunt', aliases: '-a', desc: 'Choose the assets workflow this project uses.', enum: ['grunt', 'none']
    method_option :'honeybadger-private-key', desc: "Honeybadger Private API Key"
    method_option :'honeybadger-public-key', desc: "Honeybadger Private API Key"
    method_option :'no-newrelic', type: :boolean, desc: "Don't use New Relic."
    method_option :'with-vcr', type: :boolean, desc: "Include `vcr` in this project's TDD stack."
    method_option :'with-sidekiq', type: :boolean, desc: "Set this project up to use `sidekiq` for background processing."
    def new(app)
      @app = app
      @port = options[:port]
      @ruby_version = options[:ruby_version]
      @models = options[:models]
      @assets = options[:assets]
      @honeybadger_private_key = options[:'honeybadger-private-key']
      @honeybadger_public_key = options[:'honeybadger-public-key']
      @no_newrelic = options[:'no-newrelic']
      @with_vcr = options[:'with-vcr']
      @with_sidekiq = options[:'with-sidekiq']

      case @models
      when 'datamapper'
        @datamapper = true
      when 'none'
        @datamapper = false
      end

      case @assets
      when 'grunt'
        @grunt = true
      when 'none'
        @grunt = false
      end

      # do the dew
      say "Generating #{app} app..."
      directory('_app', app)
      chmod("#{app}/bin/console", 'a+x')
      template("_templates/#{@models}.rb.tt", "#{app}/config/#{@models}.rb")
      copy_file('_templates/db_helper.rb', "#{app}/spec/db_helper.rb") if @datamapper

      if @grunt
        directory('_grunt', app)
      end

      if @with_vcr
        copy_file('_templates/vcr_helper.rb', "#{app}/spec/vcr_helper.rb")
        empty_directory("#{app}/spec/_cassettes")
        create_file("#{app}/spec/_cassettes/.gitkeep", "")
      end

      if @with_sidekiq
        template('_templates/sidekiq.rb.tt', "#{app}/config/sidekiq.rb")
        empty_directory("#{app}/lib/jobs")
        create_file("#{app}/lib/jobs/.gitkeep", "")
        append_to_file("#{app}/lib/boot.rb") do
          "# jobs\n" +
          "require File.join($app_root, 'config/sidekiq')"
        end
      end

      say "Done!"
    end

    desc "version", "Prints version number"
    def version
      say "Daiku v#{Daiku::VERSION}"
    end
  end
end
