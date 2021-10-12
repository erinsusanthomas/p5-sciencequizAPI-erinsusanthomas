FactoryBot.define do
  factory :quiz do
    association :event
    division { "senior" }
    room { 1 }
    round { 1 }
  end
end
