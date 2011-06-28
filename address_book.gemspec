# encoding: utf-8
require File.expand_path("../lib/address_book/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "address_book"
  s.version     = AddressBook::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Igor Sidorov"]
  s.email       = ["igor.cug@gmail.com"]
  s.homepage    = "https://github.com/binarycode/address_book"
  s.summary     = "Address book export"
  s.description = "Exports address books from various e-mail services (Gmail, Mail.ru, Yandex, Rambler)"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency "gdata"
  s.add_runtime_dependency "gdata19"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "patron"

  s.files        = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end
