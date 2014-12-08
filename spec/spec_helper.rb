# encoding: utf-8

ENV['RACK_ENV'] = 'test'

lib_path = File.expand_path('../../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

Bundler.setup(:default, ENV['RACK_ENV'])

require 'daiku'
require 'minitest/autorun'
require 'minitest/reporters'

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

require 'mocha/setup'
