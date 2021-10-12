FactoryBot.define do
  factory :student_team do
    association :student
    association :team
    start_date { Date.current }
    end_date { nil }
    position { 1 }
    active { true }
  end
end
