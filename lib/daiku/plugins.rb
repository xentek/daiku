# encoding: utf-8

module Daiku
  class Plugins
    def self.find_plugins
      Daiku::Plugins.constants.map do |plugin|
        Daiku::Plugins.const_get(plugin.to_s, false)
      end
    end

    def self.register_plugins
      Hash[*find_plugins.map do |plugin|
        [plugin.meta[:name], plugin.meta]
      end.flatten]
    end

    def self.has_plugins?(type)
      register_plugins.values.any? do |plugin|
        plugin[:type] == type
      end
    end

    def self.filter_plugins(value, filter = :type)
      register_plugins.values.select do |plugin|
        plugin[filter] == value
      end
    end

    def self.plugin_names(type = nil)
      plugins = if type.nil?
                  register_plugins.values
                else
                  filter_plugins(type, :type)
                end
      plugins.map { |plugin| plugin[:name] }
    end
  end
end
