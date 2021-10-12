require "test_helper"

class StudentTeamTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:student)
  should belong_to(:team)

  should validate_presence_of(:start_date)
  should validate_presence_of(:position)
  should validate_presence_of(:student_id)
  should validate_presence_of(:team_id)

  should validate_numericality_of(:position).only_integer.is_greater_than(0).is_less_than(6)
  should allow_value(2).for(:position)
  should_not allow_value(2.5).for(:position)
  should_not allow_value(-4).for(:position)
  should_not allow_value("bad").for(:position)
  should_not allow_value(nil).for(:position)

  should allow_value(7.weeks.ago.to_date).for(:start_date)
  should allow_value(2.years.ago.to_date).for(:start_date)
  should allow_value(Date.current).for(:start_date)
  should_not allow_value(1.week.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(nil).for(:start_date)

  # Context
  context "Given context" do
    setup do 
      create_organizations
      create_users
      create_teams
      create_students 
      create_student_teams
    end

    should "list student_teams alphabetically" do
      assert_equal [@anna_t1, @mason_t1, @mj_t1, @amelia_t1, @ellie_t1], StudentTeam.alphabetical
    end

    should "list student_teams chronologically" do
      assert_equal [@ellie_t1, @anna_t1, @mj_t1, @mason_t1, @amelia_t1], StudentTeam.chronological
    end

    should "list student_teams positionally" do
      assert_equal [@ellie_t1, @mj_t1, @anna_t1, @mason_t1, @amelia_t1], StudentTeam.by_position
    end

    should "list all captains" do
      assert_equal [@ellie_t1, @mj_t1], StudentTeam.captains
    end

    should "list all current student_team assignments" do
      assert_equal [@amelia_t1, @anna_t1, @ellie_t1, @mj_t1, @mason_t1], StudentTeam.current.sort_by{|st| st.student.first_name}  #In ASCII, MJ < Mason
    end

    should "list all past student_team assignments" do
      assert_equal [], StudentTeam.past  # this alone is not a sufficient test
      @anna_t1.end_date = Date.current   # so let's terminate Anna's time on her team
      @anna_t1.save
      @anna_t1.reload
      assert_equal [@anna_t1], StudentTeam.past
    end

    should "list student_teams for a given team" do
      assert_equal [@anna_t1, @ellie_t1], StudentTeam.for_team(@acac_s1).sort_by{|st| st.student.first_name} 
    end

    should "list student_teams for a given student" do
      assert_equal [@anna_t1], StudentTeam.for_student(@anna)
    end

    should "list active student_teams" do
      assert_equal 4, StudentTeam.active.count
      assert_equal [@anna_t1, @ellie_t1, @mj_t1, @mason_t1], StudentTeam.active.sort_by{|st| st.student.first_name}  #In ASCII, MJ < Mason
    end

    should "list inactive student_teams" do
      assert_equal 1, StudentTeam.inactive.count
      assert_equal [@amelia_t1], StudentTeam.inactive
    end

    should "have a make_active method" do
      deny @amelia_t1.active
      @amelia_t1.make_active
      @amelia_t1.reload
      assert @amelia_t1.active
    end

    should "have a make_inactive method" do
      assert @ellie_t1.active
      @ellie_t1.make_inactive
      @ellie_t1.reload
      deny @ellie_t1.active
    end

    should "allow for an end date in the past (or today) but after the start date" do
      # Note that we've been testing end_date: nil for a while now so safe to assume works...
      @acac_s4.make_active
      @assign_anna = FactoryBot.build(:student_team, student: @anna, team: @acac_s4, start_date: 3.weeks.ago.to_date, end_date: 1.week.ago.to_date, position: 1)
      assert @assign_anna.valid?
      @second_assignment_for_anna = FactoryBot.build(:student_team, student: @anna, team: @acac_s4, start_date: 3.weeks.ago.to_date, end_date: Date.current, position: 1)
      assert @second_assignment_for_anna.valid?
    end
    
    should "not allow for an end date in the future or before the start date" do
      @acac_s4.make_active
      @third_assignment_for_anna = FactoryBot.build(:student_team, student: @anna, team: @acac_s4, start_date: 3.weeks.ago.to_date, end_date: 1.week.from_now.to_date, position: 1)
      deny @third_assignment_for_anna.valid?
      @fourth_assignment_for_anna = FactoryBot.build(:student_team, student: @anna, team: @acac_s4, start_date: 3.weeks.ago.to_date, end_date: 4.weeks.ago.to_date, position: 1)
      deny @fourth_assignment_for_anna.valid?
    end

    should "identify a non-active student as part of an invalid assignment" do
      inactive_student = FactoryBot.create(:student, organization: @acac, first_name: "ghost", active: false)
      invalid_assignment = FactoryBot.build(:student_team, student: inactive_student, team: @acac_s1)
      deny invalid_assignment.valid?
    end

    should "identify a non-active team as part of an invalid assignment" do
      ghost_team = FactoryBot.create(:team, organization: @acac, name: "ghost", active: false, coach: @ben)
      invalid_assignment = FactoryBot.build(:student_team, team: ghost_team, student: @ellie)
      deny invalid_assignment.valid?
    end

    should "identify a non-existent student as part of an invalid assignment" do
      inactive_student = FactoryBot.build(:student, organization: @acac, first_name: "ghost", active: false)
      invalid_assignment = FactoryBot.build(:student_team, student: inactive_student, team: @acac_s1)
      deny invalid_assignment.valid?
    end

    should "identify a non-existent team as part of an invalid assignment" do
      ghost_team = FactoryBot.build(:team, organization: @acac, name: "ghost", active: false, coach: @ben)
      invalid_assignment = FactoryBot.build(:student_team, team: ghost_team, student: @ellie)
      deny invalid_assignment.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: student_is_aligned_with_team_organization
    ###         Maddie from Millvale can't be added to an ACAC team
    should "pass validate test A" do   
      maddie = FactoryBot.create(:student, organization: @millvale, first_name: 'Madeline', last_name: 'Barnes', grade: 10)
      maddie_assignment = FactoryBot.build(:student_team, student: maddie, team: @acac_s1, start_date: 19.weeks.ago.to_date, position: 3)
      deny maddie_assignment.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: student_position_is_currently_open
    ###         Maddie (from ACAC now) can't be added to Ellie's position of captain
    should "pass validate test B" do   
      maddie = FactoryBot.create(:student, organization: @acac, first_name: 'Madeline', last_name: 'Barnes', grade: 10)
      maddie_assignment = FactoryBot.build(:student_team, student: maddie, team: @acac_s1, start_date: 19.weeks.ago.to_date, position: 1)
      deny maddie_assignment.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: student_has_appropriate_grade_given_team_division (sr->jr_team)
    ###         Maddie is a senior and can't be added to a junior team
    should "pass validate test C" do   
      maddie = FactoryBot.create(:student, organization: @millvale, first_name: 'Madeline', last_name: 'Barnes', grade: 10)
      maddie_assignment = FactoryBot.build(:student_team, student: maddie, team: @millvale_j1, start_date: 19.weeks.ago.to_date, position: 4)
      deny maddie_assignment.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: student_has_appropriate_grade_given_team_division (jr->sr_team)
    ###         Maddie is now a junior who can't be added to a senior team
    should "pass validate test D" do   
      maddie = FactoryBot.create(:student, organization: @acac, first_name: 'Madeline', last_name: 'Barnes', grade: 4)
      maddie_assignment = FactoryBot.build(:student_team, student: maddie, team: @acac_s1, start_date: 19.weeks.ago.to_date, position: 4)
      deny maddie_assignment.valid?
    end

    ### Question: What is the purpose of the test below? 
    ### Answer: student_assignment_is_not_a_repeat
    ###         Ellie is already assigned to this team in position 1; can't readded
    should "pass validate test E" do   
      invalid_assignment = FactoryBot.build(:student_team, student: @ellie, team: @acac_s1, start_date: 19.weeks.ago.to_date, position: 4)
      deny invalid_assignment.valid?
    end

    should "end the current team assignment if it exists before adding a new team assignment for a student" do
      @acac_s4.make_active
      assert_equal @acac_s1, @anna.current_team
      @assign_anna = FactoryBot.create(:student_team, student: @anna, team: @acac_s4, start_date: 3.weeks.ago.to_date, end_date: nil, position: 1)
      @anna.reload
      @anna_t1.reload
      assert_equal @acac_s4, @anna.current_team
      assert_equal 3.weeks.ago.to_date, @anna_t1.end_date
    end

    should "terminate a team assignment as of today" do
      assert_nil @anna_t1.end_date
      @anna_t1.terminate_now
      @anna_t1.reload
      assert_equal Date.current, @anna_t1.end_date
    end

    should "not terminate a team assignment that is already closed" do
      @anna_t1.update_attribute(:end_date, 8.weeks.ago.to_date)
      @anna_t1.reload
      assert_equal 8.weeks.ago.to_date, @anna_t1.end_date
      @anna_t1.terminate_now
      @anna_t1.reload
      assert_equal 8.weeks.ago.to_date, @anna_t1.end_date
    end
  end
end