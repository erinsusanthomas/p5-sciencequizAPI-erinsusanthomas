FactoryBot.define do
  factory :team_quiz do
    association :team
    association :quiz
    raw_score { nil }
    team_points { nil }
    position { 1 }
  end
end
