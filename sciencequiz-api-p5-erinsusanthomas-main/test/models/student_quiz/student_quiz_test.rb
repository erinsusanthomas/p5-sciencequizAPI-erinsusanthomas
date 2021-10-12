require "test_helper"

class StudentQuizTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:student)
  should belong_to(:quiz)

  should validate_presence_of(:student_id)
  should validate_presence_of(:quiz_id)
  should validate_presence_of(:num_correct)
  should validate_presence_of(:num_attempted)
  should validate_numericality_of(:num_attempted).only_integer.is_greater_than_or_equal_to(0).is_less_than(7)
  should validate_numericality_of(:num_correct).only_integer.is_greater_than_or_equal_to(0).is_less_than(5)


  # Context
  context "Given context" do
    setup do 
      create_organizations
      create_users
      create_students
      create_events
      create_quizzes
      create_teams
      create_student_teams
      create_team_quizzes
      create_student_quizzes
    end

    should "identify a non-existent quiz as part of an invalid student-quiz" do
      ghost_quiz = FactoryBot.build(:quiz, event: @acac_e1, division: 'senior', room: 2, round: 3)
      invalid_student_quiz = FactoryBot.build(:student_quiz, quiz: ghost_quiz, student: @ellie)
      deny invalid_student_quiz.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: student_is_participating_in_this_quiz (in this case, not part of this quiz)
    ###         Rachel was inactive, part of no team, and we make her active and give her points?
    should "pass validate test A" do 
      @rachel.make_active
      invalid_student_quiz = FactoryBot.build(:student_quiz, student: @rachel, quiz: @acac_e1_s1_r1, num_attempted: 4, num_correct: 4)
      deny invalid_student_quiz.valid?
    end

  end

end
