class AddressBook
  @@domains = {}

  def self.register_service(domains, klass)
    Array(domains).each do |domain|
      @@domains[domain] = klass
    end
  end

  def self.export(login, password)
    domain = extract_domain login
    klass = @@domains[domain]
    if klass
      klass.new(login, password).contacts
    else
      raise ServiceNotFound, "No service registered for #{domain.inspect} domain"
    end
  end

  def self.extract_domain(login)
    login.split("@").last
  end

  class Base
    attr_accessor :contacts

    def session
      @session ||= Patron::Session.new.handle_cookies
    end
  end
end
