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
