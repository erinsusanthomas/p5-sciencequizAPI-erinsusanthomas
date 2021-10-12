require "test_helper"

class QuizScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_organizations
      create_events
      create_quizzes
    end

    should "list quizzes by room" do
      assert_equal [@acac_e1_s1_r1, @acac_e1_s1_r2, @acac_e3_s1_r1, @acac_e3_s1_r2,  
                    @acac_e1_s2_r1, @acac_e1_s2_r2, @acac_e3_s2_r1, @acac_e3_s2_r2,
                    @acac_e1_j3_r1, @acac_e1_j3_r2, @acac_e1_j4_r1, @acac_e1_j4_r2], Quiz.by_room.to_a
    end

    should "list quizzes by round" do
      assert_equal [@acac_e1_s1_r1, @acac_e1_s2_r1, @acac_e1_j3_r1, @acac_e1_j4_r1, @acac_e3_s1_r1, @acac_e3_s2_r1,  
                    @acac_e1_s1_r2, @acac_e1_s2_r2, @acac_e1_j3_r2, @acac_e1_j4_r2, @acac_e3_s1_r2, @acac_e3_s2_r2], Quiz.by_round.to_a
    end

    should "list quizzes for a given room" do
      assert_equal [@acac_e1_s1_r1, @acac_e1_s1_r2, @acac_e3_s1_r1, @acac_e3_s1_r2], Quiz.for_room(1).to_a
    end

    should "list quizzes for a given round" do
      assert_equal [@acac_e1_s1_r1, @acac_e1_s2_r1, @acac_e1_j3_r1, @acac_e1_j4_r1, @acac_e3_s1_r1, @acac_e3_s2_r1], Quiz.for_round(1).to_a
    end

    should "list quizzes for a given event" do
      assert_equal [@acac_e3_s1_r1, @acac_e3_s2_r1, @acac_e3_s1_r2, @acac_e3_s2_r2], Quiz.for_event(@acac_e3).to_a
    end

    should "list quizzes for seniors" do
      assert_equal [@acac_e1_s1_r1, @acac_e1_s2_r1, @acac_e1_s1_r2, @acac_e1_s2_r2, 
                    @acac_e3_s1_r1, @acac_e3_s2_r1, @acac_e3_s1_r2, @acac_e3_s2_r2], Quiz.seniors.to_a
    end

    should "list quizzes for juniors" do
      assert_equal [@acac_e1_j3_r1, @acac_e1_j4_r1, @acac_e1_j3_r2, @acac_e1_j4_r2], Quiz.juniors.to_a
    end

  end

end