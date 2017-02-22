module OpenStax::Salesforce::SpecHelpers
  class SalesforceProxy

    include OpenStax::Salesforce::Remote

    def initialize
    end

    # Used to filter records to the scope of one spec
    def reset_unique_token(token = SecureRandom.hex(10))
      @unique_token = token
    end

    def clear_unique_token
      @unique_token = nil
    end

    def new_contact(first_name: nil, last_name: nil, school_name: "JP University",
                    email: nil, email_alt: nil,
                    faculty_verified: nil)
      ensure_schools_exist([school_name])

      Contact.new(
        first_name: first_name || Faker::Name.first_name,
        last_name: last_name!(last_name),
        school_id: school_id(school_name),
        email: email,
        email_alt: email_alt,
        faculty_verified: faculty_verified
      ).tap do |contact|
        if !contact.save
          raise "Could not save SF contact: #{contact.errors}"
        end
      end
    end

    def new_lead(email:, status: nil, last_name: nil, source: nil, school_name: "JP University")
      Lead.new(
        email: email,
        status: status,
        last_name: last_name!(last_name),
        school: school_name,
        source: source
      ).tap do |lead|
        if !lead.save
          raise "Could not save SF lead: #{lead.errors}"
        end
      end
    end

    def last_name!(input)
      "#{input || Faker::Name.last_name}#{@unique_token if @unique_token.present?}"
    end

    def ensure_books_exist(book_names)
      book_names.each do |book_name|
        if books.none?{|bb| bb.name == book_name}
          book = Book.new(name: book_name)
          book.save!
          books.push(book)
        end
      end
    end

    def ensure_schools_exist(school_names)
      school_names.compact.each do |school_name|
        if schools.none?{|ss| ss.name == school_name}
          school = School.new(name: school_name)
          school.save!
          schools.push(school)
        end
      end
    end

    def books
      @books ||= Book.all
    end

    def book(name)
      books.select{|bb| bb.name == name}.first
    end

    def book_id(name)
      book(name).id
    end

    def schools
      @schools ||= School.all
    end

    def school_id(name)
      school(name).try(:id)
    end

    def school(name)
      schools.select{|ss| ss.name == name}.first
    end

  end
end
