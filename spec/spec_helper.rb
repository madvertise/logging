require 'rubygems'
require 'rspec'

require 'simplecov'
SimpleCov.start

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'liquid-logging'

RSpec.configure do |config|
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end
