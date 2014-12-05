# encoding: utf-8

if ENV['HONEYBADGER_PRIVATE_KEY']
  Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_PRIVATE_KEY']
    config.environment_name = ENV['RACK_ENV']
  end
end
