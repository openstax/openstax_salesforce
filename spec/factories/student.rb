FactoryBot.define do
  factory :student, class: OpenStax::Salesforce::Remote::Student do
    skip_create

    id { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }
    name { SecureRandom.uuid }
    school_id { Faker::Alphanumeric.alphanumeric(number: 18, min_alpha: 3, min_numeric: 3) }
    initial_book_id { Faker::Alphanumeric.alphanumeric(number: 18, min_alpha: 3, min_numeric: 3) }
    last_osweb_login_date { Faker::Date.backward(days: 365) }
  end
end
