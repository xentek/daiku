# encoding: utf-8

require 'spec_helper'

describe Daiku::Plugins do
  subject { Daiku::Plugins }
  let(:plugins) do
    [
      Daiku::Plugins::DatabaseSql,
      Daiku::Plugins::Datamapper,
      Daiku::Plugins::Grunt,
      Daiku::Plugins::Honeybadger,
      Daiku::Plugins::Newrelic,
      Daiku::Plugins::Sequel,
      Daiku::Plugins::Sidekiq,
      Daiku::Plugins::Vcr
    ]
  end

  let(:plugins_hash) do
    hash = {}
    plugins.each do |plugin|
      hash[plugin.meta[:name]] = plugin.meta
    end
    hash
  end

  let(:plugin_names) do
    plugins.map do |plugin|
      plugin.meta[:name]
    end
  end

  it "can find plugins" do
    subject.find_plugins.must_equal plugins
  end

  it "can register plugins" do
    subject.register_plugins.must_equal plugins_hash
  end

  it "returns true if a plugin of given type is present" do
    subject.has_plugins?('models').must_equal true
  end

  it "returns false if a plugin of given type is NOT present" do
    subject.has_plugins?('example').must_equal false
  end

  it "can filter plugins by type" do
    subject.filter_plugins('models', :type).must_equal [subject::Datamapper.meta, subject::Sequel.meta]
  end

  it "returns names of all plugins" do
    subject.plugin_names.must_equal plugin_names
  end

  it "returns names of plugins of type: models" do
    subject.plugin_names('models').must_equal ['datamapper', 'sequel']
  end
end
