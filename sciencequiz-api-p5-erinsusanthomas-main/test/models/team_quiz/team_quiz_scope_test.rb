require "test_helper"

class TeamQuizScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_organizations
      create_users
      create_teams
      create_events
      create_quizzes
      create_team_quizzes
    end

    should "list team_quizzes alphabetically by team name" do
      assert_equal ["ACAC 1", "ACAC 1", "ACAC 1", "ACAC 1", "Millvale 1", "Millvale 1"], TeamQuiz.by_team.map{|tq| tq.team.name}
    end

    should "list team_quizzes by team position" do
      assert_equal [@acac_s1_e1_s2_r2, @millvale_j1_e1_j4_r2, 
                    @acac_s1_e1_s1_r1, @acac_s1_e3_s1_r2, 
                    @acac_s1_e3_s2_r1, @millvale_j1_e1_j3_r1], TeamQuiz.by_position.to_a
    end

    should "list team_quizzes by quiz round and room" do
      assert_equal [@acac_s1_e1_s1_r1, @acac_s1_e3_s2_r1, @millvale_j1_e1_j3_r1, 
                    @acac_s1_e3_s1_r2, @acac_s1_e1_s2_r2, @millvale_j1_e1_j4_r2], TeamQuiz.by_quiz.to_a
    end

    should "list team_quizzes by team points" do
      assert_equal [@acac_s1_e1_s1_r1, @millvale_j1_e1_j4_r2, @acac_s1_e1_s2_r2, @millvale_j1_e1_j3_r1, @acac_s1_e3_s1_r2, @acac_s1_e3_s2_r1], TeamQuiz.by_team_points.to_a
    end

    should "list team_quizzes for a given team" do
      assert_equal [@millvale_j1_e1_j3_r1, @millvale_j1_e1_j4_r2], TeamQuiz.for_team(@millvale_j1)
    end

    should "list team_quizzes for a given quiz" do
      assert_equal [@acac_s1_e1_s1_r1], TeamQuiz.for_quiz(@acac_e1_s1_r1)
    end

  end
end