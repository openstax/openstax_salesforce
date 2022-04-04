FactoryBot.define do
  factory :book, class: OpenStax::Salesforce::Remote::Book do
    skip_create

    id { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }
    name { Faker::Book.title }
    official_name { Faker::Book.title }
    annualization_number { Faker::Number.decimal(l_digits: 5, r_digits: 2) }

  end
end
