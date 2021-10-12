FactoryBot.define do
  factory :team do
    name { "ACAC 1" }
    association :organization
    division { "senior" }
    active { true }
    association :coach
  end
end
