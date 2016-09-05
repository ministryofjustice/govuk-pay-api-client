ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'excon'
require 'pry'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include ActiveSupport::Testing::TimeHelpers

  config.before(:all) do
    Excon.defaults[:mock] = true
  end

  config.before(:each) do
    I18n.locale = I18n.default_locale
  end

  config.after(:each) do
    Excon.stubs.clear
  end
end
