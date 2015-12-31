ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def json(body)
  	# turns { 'name' => 'foo' }
  	# into { :name => 'foo' }
  	JSON.parse(body, symbolize_names: true)
  end 
end
