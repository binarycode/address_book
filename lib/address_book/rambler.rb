class AddressBook
  class Rambler < Base
    LOGIN_URL = "http://id.rambler.ru/script/auth.cgi"
    ADDRESS_BOOK_URL = "http://mail.rambler.ru/mail/contacts.cgi"

    AddressBook.register_service %w(rambler.ru lenta.ru myrambler.ru autorambler.ru ro.ru r0.ru), self

    def initialize(login, password)
      response = session.post LOGIN_URL, { :login => login, :domain => AddressBook.extract_domain(login), :passw => password }

      if response.body.index "errorbox"
        raise AuthenticationError, "Username or password are incorrect"
      end

      response = session.get ADDRESS_BOOK_URL

      self.contacts = Nokogiri::XML.parse(response.body).css("#mailbox-list tbody tr").map do |e|
        name = e.at_css(".mtbox-name").content.strip
        email = e.at_css(".mtbox-email").content.strip
        [name, email]
      end
    end
  end
end
