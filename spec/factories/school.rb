FactoryBot.define do
  factory :school, class: OpenStax::Salesforce::Remote::School do
    skip_create

    name { Faker::University.name }
    city { Faker::Address.city }
    state { Faker::Address.country }
    country { Faker::Address.country }
    type do
      ['High School',
       'College/University (4)',
       'K-12 School',
       'Technical/Community College (2)',
       'Career School/For-Profit (2)'].sample
    end
    school_location { %w[Domestic Foreign].sample }
    sheerid_school_name { %w[Domestic Foreign].sample }
    is_kip { Faker::Boolean.boolean }
    is_child_of_kip { Faker::Boolean.boolean }
    total_school_enrollment { Faker::Number.between(from: 0, to: 5000)}
  end
end
