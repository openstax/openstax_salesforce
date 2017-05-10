FactoryGirl.define do
  factory :user, class: 'OpenStax::Salesforce::User' do
    uid           { SecureRandom.hex(10) }
    name          { Faker::Name.name }
    oauth_token   { SecureRandom.hex }
    refresh_token { SecureRandom.hex }
    instance_url  { Faker::Internet.url }

    transient do
      do_not_destroy_others false
    end

    after(:build) do |user, evaluator|
      user.define_singleton_method(:ensure_only_one_record) {} if evaluator.do_not_destroy_others
    end
  end
end
