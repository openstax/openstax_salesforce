FactoryBot.define do
  factory :openstax_account, class: OpenStax::Salesforce::Remote::OpenStaxAccount do
    skip_create

    association :contact
    association :lead

    account_id { Faker::Number.positive }
    account_uuid { Faker::Internet.uuid }
    account_role { %w[Unknown Instructor Student].sample }
    faculty_status { %w[no_info incomplete_signup pending_faculty rejected_by_sheer_id rejected_faculty confirmed_faculty].sample }
    signup_date { DateTime.now }
    account_environment { %w[production staging qa dev local].sample }
  end
end
