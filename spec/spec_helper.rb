require "rspec"
require "rack/test"

ENV["RACK_ENV"] = "test"
require_relative "../lib/sisimai_web/app.rb"

module TestHelper
  include Rack::Test::Methods

  def each_fixture(&block)
    soft    = 1
    hard    = 0
    unknown = -1

    {
      "auto_earthlink"   => { bounce: unknown, reason: "vacation",        replycode: "" },
      "bounce_aol"       => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_att"       => { bounce: soft,    reason: "spamdetected",    replycode: "521" },
      "bounce_charter"   => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_cox"       => { bounce: soft,    reason: "suspend",         replycode: "550" },
      "bounce_earthlink" => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_exchange"  => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_gmail"     => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_hotmail"   => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_me"        => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_postfix"   => { bounce: hard,    reason: "userunknown",     replycode: "550" },
      "bounce_spam"      => { bounce: soft,    reason: "notcompliantrfc", replycode: "554" },
      "bounce_yahoo"     => { bounce: hard,    reason: "userunknown",     replycode: "554" },
      "ordinary_gmail"   => { bounce: false },
    }.each(&block)
  end

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
  config.extend TestHelper
end
