# encoding: utf-8
ENV['RACK_ENV'] = 'test'
dbuser = (ENV['TRAVIS']) ? 'postgres@' : nil
ENV['DB_NAME_TEST'] = "#{ENV['DB_NAME']}_test"
ENV['DATABASE_URL'] = "postgres://#{dbuser}localhost/#{ENV['DB_NAME_TEST']}"
lib_path = File.expand_path('../../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)
require 'boot'
Bundler.setup(:test)
require 'minitest/autorun'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
