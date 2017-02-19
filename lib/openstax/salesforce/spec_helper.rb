module OpenStax::Salesforce
  class SpecHelper

    def initialize
    end

    def new_contact(first_name: nil, last_name: nil, school_name: "JP University")
      ensure_schools_exist([school_name])

      Remote::Contact.new(
        first_name: first_name || Faker::Name.first_name,
        last_name: last_name || Faker::Name.last_name,
        school_id: school_id(school_name)
      ).tap do |contact|
        if !contact.save
          raise "Could not save SF contact: #{contact.errors}"
        end
      end
    end

    def ensure_books_exist(book_names)
      book_names.each do |book_name|
        if books.none?{|bb| bb.name == book_name}
          book = Remote::Book.new(name: book_name)
          book.save!
          books.push(book)
        end
      end
    end

    def ensure_schools_exist(school_names)
      school_names.compact.each do |school_name|
        if schools.none?{|ss| ss.name == school_name}
          school = Remote::School.new(name: school_name)
          school.save!
          schools.push(school)
        end
      end
    end

    def books
      @books ||= Remote::Book.all
    end

    def book(name)
      books.select{|bb| bb.name == name}.first
    end

    def book_id(name)
      book(name).id
    end

    def schools
      @schools ||= Remote::School.all
    end

    def school_id(name)
      school(name).try(:id)
    end

    def school(name)
      schools.select{|ss| ss.name == name}.first
    end

    def self.load_salesforce_user
      clear_salesforce_user

      config = OpenStax::Salesforce.configuration
      sf_user = OpenStax::Salesforce::User.new

      sf_user.name = "some name"
      sf_user.uid = "whatever"
      sf_user.oauth_token =   config.sandbox_oauth_token
      sf_user.refresh_token = config.sandbox_refresh_token
      sf_user.instance_url =  config.sandbox_instance_url.tap do |url|
        if config.check_sandbox_instance_url && !url.match(/\/\/cs/)
          raise "Salesforce sandbox instance URL (#{url}) does not have the expected form!"
        end
      end

      sf_user.save!
    end

    def self.clear_salesforce_user
      OpenStax::Salesforce::User.destroy_all
    end

  end
end
