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

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.add_dependency "gdata", ">= 1.1.2"
  s.add_dependency "gdata19", ">= 0.1.9.2"
  s.add_dependency "nokogiri", ">= 1.4.6"
  s.add_dependency "patron", ">= 0.4.12"

  s.files        = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end
