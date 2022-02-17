module OpenStax::Salesforce::SpecHelpers
  # Uses knowledge of how `SalesforceProxy` methods create new SF records using its
  # `unique_token` to create the conditions you'd otherwise have to manually set
  # when calling `limit_salesforce_queries`.
  #
  def limit_salesforce_queries_by_token(remote_class, token)
    case remote_class.new
    when OpenStax::Salesforce::Remote::Contact, OpenStax::Salesforce::Remote::Lead
      limit_salesforce_queries(remote_class, last_name: "%#{token}")
    else
      raise "Don't know how to apply to #{remote_class}"
    end
  end

  # Often, when dealing with Salesforce sandboxes, there are a bunch of other records
  # in the sandbox that you'd rather your specs ignore.  This method makes SF queries
  # in your specs have additional `where` clauses to limit what is returned.  If you
  # are careful how you create the records you are testing against, you can use this
  # method to only consider those records.  E.g. when creating a contact, if you make
  # each of the last names end with "_foobar", then by saying:
  #
  #   limit_salesforce_queries(OpenStax::Salesforce::Remote::Contact, last_name: "%_foobar")
  #
  # your Contact queries will only return the one you made with the last name ending
  # in "_foobar".  The methods in SalesforceProxy that help you make SF records
  # use the `unique_token` in this way (set via `reset_unique_token`).
  #
  def limit_salesforce_queries(remote_class, **conditions)
    allow(remote_class).to receive(:query) do
      like_conditions = {}
      other_conditions = {}

      conditions.each_pair do |key, value|
        if value.is_a?(String) && value.include?("%")
          like_conditions[key] = value
        else
          other_conditions[key] = value
        end
      end

      like_queries = like_conditions.map do |key, value|
        attribute = remote_class.mapping.mappings[key]
        quoted_value = "'#{value.gsub(/\\/, '\&\&').gsub(/'/, "''")}'"
        "#{attribute} LIKE #{quoted_value}"
      end

      result = remote_class.original_query

      like_queries.each do |like_query|
        result = result.where(like_query)
      end

      result = result.where(other_conditions) if other_conditions.any?
      result
    end
  end

  class SalesforceProxy
    include OpenStax::Salesforce::Remote

    def initialize
      # For cassette consistency, to ensure specs always get new tokens
      ActiveForce.clear_sfdc_client!
    end

    # Used to filter records to the scope of one spec
    def reset_unique_token(token = SecureRandom.hex(10))
      @unique_token = token
    end

    def clear_unique_token
      @unique_token = nil
    end

    def new_contact(first_name: nil, last_name: nil, school_name: "RSpec University",
                    email: nil, faculty_verified: nil, school_type: nil)
      ensure_schools_exist([school_name])

      Contact.new(
        first_name: first_name || Faker::Name.first_name,
        last_name: last_name || Faker::Name.last_name,
        school_id: school_id(school_name),
        email: email || Faker::Internet.safe_email,
        faculty_verified: faculty_verified,
        school_type: school_type
      ).tap do |contact|
        raise "Could not save SF contact: #{contact.errors}" unless contact.save
      end
    end

    def new_lead(email:, status: nil, last_name: nil, source: nil)
      Lead.new(
        email: email,
        status: status,
        last_name: last_name!(last_name),
        school: 'RSpec University',
        source: source
      ).tap do |lead|
        raise "Could not save SF lead: #{lead.errors}" unless lead.save
      end
    end

    def new_campaign(name: SecureRandom.hex(8))
      Campaign.new(
        name: name
      ).tap do |campaign|
        raise "Could not save SF Campaign: #{campaign.errors}" unless campaign.save
      end
    end

    def new_campaign_member(contact_id:, campaign_id:)
      CampaignMember.new(
        contact_id: contact_id,
        campaign_id: campaign_id
      ).tap do |campaign_member|
        raise "Could not save SF Campaign Member: #{campaign_member.errors}" unless campaign_member.save
      end
    end

    def last_name!(input)
      "#{input || Faker::Name.last_name}#{@unique_token if @unique_token.present?}"
    end

    def ensure_books_exist(book_names)
      @books = OpenStax::Salesforce::Remote::Book.where(name: book_names).to_a

      (book_names - books.map(&:name)).each do |book_name|
        OpenStax::Salesforce::Remote::Book.new(
          name: book_name, annualization_number: [ 1.4, 1.6 ].sample
        ).save!
      end
    end

    def ensure_schools_exist(school_names)
      @schools = OpenStax::Salesforce::Remote::School.where(name: school_names).to_a

      (school_names - schools.map(&:name)).each do |school_name|
        OpenStax::Salesforce::Remote::School.new(name: school_name).save!
      end
    end

    def books
      @books ||= OpenStax::Salesforce::Remote::Book.all
    end

    def book(name)
      books.find { |bb| bb.name == name }
    end

    def book_id(name)
      book(name).id
    end

    def schools
      @schools ||= OpenStax::Salesforce::Remote::School.all
    end

    def school_id(name)
      school(name).try(:id)
    end

    def school(name)
      schools.find { |ss| ss.name == name }
    end

    def setup_cassette
      VCR.configure do |config|
        config.define_cassette_placeholder('<salesforce_instance_url>') do
          'https://example.salesforce.com'
        end
        config.define_cassette_placeholder('<salesforce_instance_url_lower>') do
          'https://example.salesforce.com'
        end
        authentication = ActiveForce.sfdc_client.authenticate!
        config.define_cassette_placeholder('<salesforce_instance_url>') do
          authentication.instance_url
        end
        config.define_cassette_placeholder('<salesforce_instance_url_lower>') do
          authentication.instance_url.downcase
        end
        config.define_cassette_placeholder('<salesforce_id>') do
          authentication.id
        end
        config.define_cassette_placeholder('<salesforce_access_token>') do
          authentication.access_token
        end
        config.define_cassette_placeholder('<salesforce_signature>') do
          authentication.signature
        end
      end
    end
  end
end
