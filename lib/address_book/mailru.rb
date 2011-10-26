require "csv"

class AddressBook
  class MailRu < Base
    LOGIN_URL = "https://auth.mail.ru/cgi-bin/auth"
    ADDRESS_BOOK_URL = "http://e.mail.ru/cgi-bin/abexport/addressbook.csv"
    
    AddressBook.register_service %w(mail.ru inbox.ru bk.ru list.ru), self

    def initialize(login, password)
      response = session.post LOGIN_URL, { :Login => login, :Domain => AddressBook.extract_domain(login), :Password => password }

      if response.body.index "fail=1"
        raise AuthenticationError, "Username or password are incorrect"
      end

      response = session.post ADDRESS_BOOK_URL, { :confirm => 1, :abtype => 6 }

      self.contacts = CSV.parse(response.body).drop(1).map do |row|
        [row[0], row[4]] rescue nil
      end

      self.contacts.compact!
    end
  end
end
