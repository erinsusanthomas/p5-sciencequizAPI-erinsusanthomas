require "test_helper"

class TeamQuizTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:team)
  should belong_to(:quiz)

  should validate_numericality_of(:raw_score).only_integer.allow_nil
  should validate_numericality_of(:team_points).is_greater_than_or_equal_to(0).only_integer.allow_nil
  should validate_inclusion_of(:position).in_array([1, 2, 3])
  

  # Context
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

    should "identify a non-active team as part of an invalid matchup" do
      acac_e1_s2_r3 = FactoryBot.create(:quiz, event: @acac_e1, division: 'senior', room: 2, round: 3)
      inactive_team = FactoryBot.create(:team, organization: @acac, name: "ghost", active: false, coach: @ben)
      invalid_matchup = FactoryBot.build(:team_quiz, team: inactive_team, quiz: acac_e1_s2_r3)
      deny invalid_matchup.valid?
    end

    should "identify a non-existent quiz as part of an invalid matchup" do
      ghost_quiz = FactoryBot.build(:quiz, event: @acac_e1, division: 'senior', room: 1, round: 3)
      invalid_matchup = FactoryBot.build(:team_quiz, quiz: ghost_quiz, team: @acac_s1)
      deny invalid_matchup.valid?
    end

    should "identify a non-existent team as part of an invalid matchup" do
      acac_e1_s2_r3 = FactoryBot.create(:quiz, event: @acac_e1, division: 'senior', room: 2, round: 3)
      ghost_team = FactoryBot.build(:team, organization: @acac, name: "ghost", active: false, coach: @ben)
      invalid_matchup = FactoryBot.build(:team_quiz, team: ghost_team, quiz: acac_e1_s2_r3)
      deny invalid_matchup.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: team_matchup_count_less_than_max (up to 3 okay)
    ###         Adding two extra teams to quiz is fine
    should "pass validate test A" do   
      @acac_s2 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 2', division: 'senior', coach: @ben)
      @acac_s3 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 3', division: 'senior', coach: @ben)
      acac_s2_e1_s1_r1 = FactoryBot.create(:team_quiz, team: @acac_s2, quiz: @acac_e1_s1_r1, raw_score: 120, team_points: 12, position: 1)
      acac_s3_e1_s1_r1 = FactoryBot.build(:team_quiz, team: @acac_s3, quiz: @acac_e1_s1_r1, raw_score: 120, team_points: 12, position: 3)
      assert acac_s3_e1_s1_r1.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: team_matchup_count_less_than_max (more than 3 invalid)
    ###         Adding a fourth team to a quiz is not allowed
    should "pass validate test B" do   
      @acac_s2 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 2', division: 'senior', coach: @ben)
      @acac_s3 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 3', division: 'senior', coach: @ben)
      @acac_s4.make_active
      acac_s2_e1_s1_r1 = FactoryBot.create(:team_quiz, team: @acac_s2, quiz: @acac_e1_s1_r1, raw_score: 120, team_points: 12, position: 1)
      acac_s3_e1_s1_r1 = FactoryBot.create(:team_quiz, team: @acac_s3, quiz: @acac_e1_s1_r1, raw_score: 120, team_points: 12, position: 3)
      invalid_matchup = FactoryBot.build(:team_quiz, team: @acac_s4, quiz: @acac_e1_s1_r1, raw_score: 120, team_points: 12, position: 2)
      deny invalid_matchup.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: matchup_is_not_a_repeat (same team, different position)
    ###         Exact match for acac_s1_e1_s1_r1, save the position
    should "pass validate test C" do 
      @acac_s4.make_active
      acac_s1_e1_s1_r1a = FactoryBot.build(:team_quiz, team: @acac_s1, quiz: @acac_s1_e1_s1_r1.quiz, raw_score: 120, team_points: 12, position: 3)
      deny acac_s1_e1_s1_r1a.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer:  matchup_position_is_currently_open (passing)
    ###          Okay to add ACAC S4 to a quiz in an open position
    should "pass validate test D" do   
      @acac_s4.make_active
      acac_s4_e1_s1_r1 = FactoryBot.build(:team_quiz, team: @acac_s4, quiz: @acac_s1_e1_s1_r1.quiz, raw_score: 120, team_points: 12, position: 3)
      assert acac_s4_e1_s1_r1.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: matchup_position_is_currently_open (failing)
    ### Adding ACAC S4 to the same position as ACAC S1 is bad
    should "pass validate test E" do   
      @acac_s4.make_active
      acac_s4_e1_s1_r1 = FactoryBot.build(:team_quiz, team: @acac_s4, quiz: @acac_s1_e1_s1_r1.quiz, raw_score: 120, team_points: 12, position: 2)
      deny acac_s4_e1_s1_r1.valid?
    end
  end

end