require "patron"
require "nokogiri"

class AddressBook
  class << self
    attr_accessor :domains

    def register_service(list, klass)
      self.domains ||= {}
      Array(list).each do |domain|
        self.domains[domain] = klass
      end
    end

    def extract_domain(login)
      login.split("@").last
    end

    def export(login, password)
      domain = extract_domain login
      service = domains[domain]
      if service 
        service.new(login, password).contacts
      else
        raise ServiceNotFound, "No service registered for #{domain.inspect} domain"
      end
    end
  end

  class Base
    attr_accessor :contacts

    def session
      @session ||= Patron::Session.new.handle_cookies
    end
  end

  class ServiceNotFound < StandardError
  end

  class AuthenticationError < StandardError
  end
end
