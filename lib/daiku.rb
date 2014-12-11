# encoding: utf-8

require 'thor'

lib_path = File.expand_path('../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

module Daiku ; end

require 'daiku/core_ext'

require 'daiku/plugin'
require 'daiku/plugins'

require 'daiku/plugins/database-sql'
require 'daiku/plugins/database-sql/cli'

require 'daiku/plugins/datamapper'
require 'daiku/plugins/datamapper/cli'

require 'daiku/plugins/grunt'
require 'daiku/plugins/grunt/cli'

require 'daiku/plugins/honeybadger'
require 'daiku/plugins/honeybadger/cli'

require 'daiku/plugins/newrelic'
require 'daiku/plugins/newrelic/cli'

require 'daiku/plugins/sequel'
require 'daiku/plugins/sequel/cli'

require 'daiku/plugins/sidekiq'
require 'daiku/plugins/sidekiq/cli'

require 'daiku/plugins/vcr'
require 'daiku/plugins/vcr/cli'

require 'daiku/version'
require 'daiku/cli'
