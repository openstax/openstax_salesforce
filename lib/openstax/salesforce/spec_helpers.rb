require 'openstax/salesforce/spec_helpers/salesforce_proxy'

module OpenStax::Salesforce::SpecHelpers

  def load_salesforce_user
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

  def clear_salesforce_user
    OpenStax::Salesforce::User.destroy_all
  end

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

end
