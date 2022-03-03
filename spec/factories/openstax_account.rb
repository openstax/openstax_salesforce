FactoryBot.define do
  factory :openstax_account, class: OpenStax::Salesforce::Remote::OpenStaxAccount do
    skip_create

    association :contact
    association :lead

    account_id { Faker::Number.positive }
    account_uuid { Faker::Internet.uuid }
    role { Faker::Name.last_name }
    signup_date { DateTime.now }
  end
end
