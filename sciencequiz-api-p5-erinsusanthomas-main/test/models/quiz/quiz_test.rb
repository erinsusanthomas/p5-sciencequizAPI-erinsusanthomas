require "test_helper"

class QuizTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:event)
  should have_many(:student_quizzes)
  should have_many(:students).through(:student_quizzes)
  should have_many(:team_quizzes)
  should have_many(:teams).through(:team_quizzes)

  should validate_presence_of(:event_id)
  should validate_presence_of(:division)
  should validate_presence_of(:room)
  should validate_presence_of(:round)
  should validate_numericality_of(:room).is_greater_than(0).only_integer
  should validate_numericality_of(:round).is_greater_than(0).only_integer
  should validate_inclusion_of(:division).in_array(%w[senior junior])

  # Context
  context "Given context" do
    setup do 
      create_organizations
      create_events
      create_quizzes
    end

    should "identify a non-active event as part of an invalid quiz" do
      inactive_event = FactoryBot.create(:event, organization: @acac, active: false)
      invalid_quiz = FactoryBot.build(:quiz, event: inactive_event, division: 'senior', room: 1, round: 1)
      deny invalid_quiz.valid?
    end

    should "identify a non-existent event as part of an invalid quiz" do
      ghost_event = FactoryBot.build(:event, organization: @acac)
      invalid_quiz = FactoryBot.build(:quiz, event: ghost_event, division: 'senior', room: 1, round: 1)
      deny invalid_quiz.valid?
    end

  end

end