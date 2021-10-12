require "test_helper"

class StudentQuizScopeTest < ActiveSupport::TestCase

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

    should "list student_quizzes alphabetically by student name" do
      assert_equal ["Davis", "Davis", "Moon", "Moon", "Nelson", "Nelson", "Smith", "Smith", "Wilshire", "Wilshire"], StudentQuiz.by_student.map{|sq| sq.student.last_name}
    end

    should "list student_quizzes by score" do
      assert_equal [@ellie_acac_e1_s1_r1, @ellie_acac_e1_s1_r2, @mj_acac_e1_j4_r2, @anna_acac_e1_s1_r1, 
                    @mj_acac_e1_j3_r1, @mason_acac_e1_j3_r1, @mason_acac_e1_j4_r2, @anna_acac_e1_s1_r2,
                    @amelia_acac_e1_j3_r1, @amelia_acac_e1_j4_r2], StudentQuiz.by_score.to_a 
    end

    should "list student_quizzes by quiz" do
      assert_equal [@ellie_acac_e1_s1_r1, @anna_acac_e1_s1_r1,
                    @mj_acac_e1_j3_r1, @mason_acac_e1_j3_r1, @amelia_acac_e1_j3_r1,
                    @ellie_acac_e1_s1_r2, @anna_acac_e1_s1_r2,
                    @mj_acac_e1_j4_r2, @mason_acac_e1_j4_r2, @amelia_acac_e1_j4_r2], StudentQuiz.by_quiz.to_a 
    end

    should "list student_quizzes for a given student" do
      assert_equal [@ellie_acac_e1_s1_r1, @ellie_acac_e1_s1_r2], StudentQuiz.for_student(@ellie).to_a
    end

    should "list student_quizzes for a given quiz" do
      assert_equal [@ellie_acac_e1_s1_r1, @anna_acac_e1_s1_r1], StudentQuiz.for_quiz(@acac_e1_s1_r1).to_a
    end

  end

end
