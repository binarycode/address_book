class AddressBook
  class Yandex < Base
    LOGIN_URL = "http://passport.yandex.ru/passport?mode=auth"
    ADDRESS_BOOK_URL = "https://mail.yandex.ru/neo2/handlers/handlers.jsx" 

    AddressBook.register_service "yandex.ru", self

    def initialize(login, password)
      response = session.post LOGIN_URL, { :login => login, :passwd => password }

      if response.body.index "b-login-error"
        raise AuthenticationError, "Username or password are incorrect"
      end

      response = session.post ADDRESS_BOOK_URL, { :_handlers => "abook-contacts", :all => "yes" }

      self.contacts = Nokogiri::XML.parse(response.body).css("contact").map do |contact|
        name = contact.at_css "name"
        email = contact.at_css "email"
        [name.values.join(" "), email.content]
      end
    end
  end
end

