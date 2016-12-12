# This calls the main test_helper in Foreman-core
require 'test_helper'
require 'controllers/shared/basic_rest_response_test'

# Add plugin to FactoryGirl's paths
FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryGirl.reload

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest_4
    with.library :rails
  end
end
