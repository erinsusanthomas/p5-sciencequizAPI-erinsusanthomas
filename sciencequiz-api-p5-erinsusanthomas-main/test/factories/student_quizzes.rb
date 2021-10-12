FactoryBot.define do
  factory :student_quiz do
    association :student
    association :quiz
    score { 0 }
    num_attempted { 0 }
    num_correct { 0 }
  end
end
