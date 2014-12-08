# encoding: utf-8

module Daiku
  class Plugin
    def self.plugin_name(name)
      meta[:name] = name
    end

    def self.plugin_type(type)
      meta[:type] = type
    end

    def self.meta
      @meta = { class: Kernel.const_get(self.name) } if @meta.nil?
      @meta
    end

    def self.cli
      meta[:class]::CLI
    end

    def self.cli_path
      File.expand_path('../', __FILE__)
    end
  end
end
