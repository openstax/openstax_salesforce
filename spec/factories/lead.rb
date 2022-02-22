FactoryBot.define do
  factory :lead, class: OpenStax::Salesforce::Remote::Lead do
    skip_create

    name { Faker::Name.name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    salutation { Faker::Name.suffix }
    subject { %i[biology chemistry psychology economics].sample }
    school { Faker::University.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
    state_code { Faker::Address.state_abbr }
    country { Faker::Address.country }
    phone { Faker::PhoneNumber.cell_phone }
    website { Faker::Internet.url(host: 'example.com') }
    status { %w[Unqualified Converted Lost].sample }
    email { Faker::Internet.safe_email }
    source { %w[Account\ Signup Web Tutor\ Signup].sample }
    newsletter { Faker::Boolean.boolean }
    newsletter_opt_in { Faker::Boolean.boolean }
    adoption_status { %w[Confirmed Adoption Won Confirmed Adoption Recommend High Interest In Using Not Using].sample }
    adoption_json { '{}' }
    num_students  { Faker::Number.between(from: 0, to: 300) }
    os_accounts_id { Faker::Number.number(digits: 10) }
    accounts_uuid { Faker::Internet.uuid }
    application_source { %w[Tutor Signup OS Web Accounts Formsite SFAPI].sample }
    role { %w[Student Instructor].sample }
    who_chooses_books { %w[instructor committee coordinator].sample }
    verification_status { %w[pending_faculty confirmed_faculty rejected_faculty].sample }
    position { %w[Student Instructor].sample }
    title { %w[Instructor Administrator Principle].sample }
  end

  trait :without_validations do
    to_create { |instance| instance.save(validate: false) }
  end
end
