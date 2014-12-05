# encoding: utf-8

require 'spec_helper'
Bundler.require(:web)
require File.join($app_root, 'app')

describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  describe "\n  GET /" do  
    it "should respond successfully" do
      get '/'
      last_response.status.must_equal 200
    end
  end
end
