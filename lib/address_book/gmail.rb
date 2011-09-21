require "gdata"

class AddressBook
  class Gmail < Base
    ADDRESS_BOOK_URL = "http://www.google.com/m8/feeds/contacts/default/full/?max-results=1000"

    AddressBook.register_service "gmail.com", self

    def initialize(login, password)
      client = GData::Client::Contacts.new
      client.clientlogin login, password

      self.contacts = Nokogiri::XML.parse(client.get(ADDRESS_BOOK_URL).body).css("entry").map do |e|
        name = (e > "title").first.content rescue nil
        email = e.at_xpath("gd:email")[:address] rescue nil
        [name, email]
      end

      self.contacts.reject! { |i| i.second.nil? }
    rescue GData::Client::AuthorizationError
      raise AuthenticationError, "Username or password are incorrect"
    end
  end
end
