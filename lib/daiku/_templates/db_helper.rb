# encoding: utf-8

require 'database_cleaner'
DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  before(:each) do
    DatabaseCleaner.start
  end

  after(:after) do
    DatabaseCleaner.clean
  end
end
