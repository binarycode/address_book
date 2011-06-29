require "spec_helper"

describe AddressBook do
  let(:accounts) { YAML.load(File.open("./spec/fixtures/accounts.yml")) }

  %w(yandex mailru rambler gmail).each do |service|
    context service.capitalize do
      let(:account) { accounts[service] }

      use_vcr_cassette service

      context "with invalid credentials" do
        it "should raise AuthenticationError" do
          expect { AddressBook.export(account[:login], nil) }.to raise_error AddressBook::AuthenticationError
        end
      end

      context "with valid credentials" do
        it "should fetch address book" do
          AddressBook.export(account[:login], account[:password]).each do |contact|
            account[:contacts][contact[1]].should == contact[0]
          end
        end
      end
    end
  end

  describe ".register_service" do
    subject { AddressBook.domains }

    context "given array of domains" do
      it "associates all domains with given class" do
        AddressBook.register_service [:domain1, :domain2], String
        should include :domain1 => String, :domain2 => String
      end
    end

    context "given one domain" do
      it "associates that domain with given class" do
        AddressBook.register_service :domain, String
        should include :domain => String
      end
    end
  end

  describe ".extract_domain" do
    it "returns the domain part of email" do
      AddressBook.extract_domain("igor.cug@gmail.com").should == "gmail.com"
    end
  end

  describe ".export" do
    context "when called for valid service" do
      it "should export user contacts from this service" do
        foo = double()
        
        AddressBook.register_service "foo", foo

        foo.should_receive(:new).and_return foo
        foo.should_receive(:contacts).and_return foo

        AddressBook.export("test@foo", nil).should == foo
      end
    end

    context "when called for invalid service" do
      it "should raise ServiceNotFound" do
        expect { AddressBook.export("foobar", nil) }.to raise_error AddressBook::ServiceNotFound
      end
    end
  end
end
