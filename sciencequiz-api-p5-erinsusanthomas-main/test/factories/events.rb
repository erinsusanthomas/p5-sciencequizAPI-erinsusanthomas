FactoryBot.define do
  factory :event do
    date { 1.month.ago.to_date }
    association :organization
    active { true }
  end
end
