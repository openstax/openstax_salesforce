FactoryBot.define do
  factory :book, class: OpenStax::Salesforce::Remote::Book do
    skip_create

    id { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }
    name { Faker::Book.title }

  end
end
