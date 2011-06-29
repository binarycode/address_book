$:.unshift(File.dirname(__FILE__) + '/../lib')

require "rubygems"
require "bundler"

Bundler.require

require "vcr"
require "address_book"

VCR.config do |config|
  config.cassette_library_dir = "spec/fixtures"
  config.stub_with :webmock
  config.default_cassette_options = { :record => :new_episodes, :match_requests_on => [:uri, :method, :body] }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
