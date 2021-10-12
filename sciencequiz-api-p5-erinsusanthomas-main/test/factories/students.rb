FactoryBot.define do
  factory :student do
    first_name { "Ellie" }
    last_name { "Wilshire" }
    grade { 9 }
    association :organization
    active { true }
  end
end
