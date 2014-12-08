# encoding: utf-8

module Daiku
  class Plugins
    class Sidekiq < ::Daiku::Plugin
      plugin_name 'sidekiq'
      plugin_type 'jobs'
    end
  end
end
