require "rspec"
require "rack/test"

ENV["RACK_ENV"] = "test"
require_relative "../lib/sisimai_web/app.rb"

module TestHelper
  include Rack::Test::Methods

  def app
    SisimaiWeb::App
  end

  def read_fixture(name)
    File.read File.expand_path("./fixtures/#{name}", __dir__)
  end
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = false

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10

  config.order = :random
  Kernel.srand config.seed

  config.include TestHelper
end
