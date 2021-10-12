FactoryBot.define do
  factory :organization do
    name { "Millvale Alliance" }
    street_1 { "10 Sherman St" }
    street_2 { nil }
    city { "Pittsburgh" }
    state { "PA" }
    zip { "15209" }
    short_name { "Millvale" }
    active { true }
  end
end
