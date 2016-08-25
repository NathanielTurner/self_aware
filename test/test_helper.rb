ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require 'minitest/spec'
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/pride"
include FeatureHelper
require 'minitest/metadata'
include Devise::TestHelpers

class ActiveSupport::TestCase
  fixtures :all
  include MiniTest::Metadata
end
