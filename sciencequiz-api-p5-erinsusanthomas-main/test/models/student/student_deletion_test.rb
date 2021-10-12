require 'test_helper'

class StudentDeletionTest < ActiveSupport::TestCase
  # Context
  context "Within context" do
    setup do
      create_organizations
      create_users
      create_teams
      create_students 
      create_student_teams
      create_events
      create_quizzes
      create_team_quizzes
      create_student_quizzes
    end

    should "be able destroy students without prior quizzes" do
      # Make Rachel (who has never participated in a quiz) active and 
      # assign her to a team before destroying her
      deny @rachel.active
      @rachel.make_active
      rachel_t1 = FactoryBot.create(:student_team, student: @rachel, team: @acac_s1, start_date: 19.weeks.ago.to_date, position: 3)
      @rachel.reload
      assert_equal @acac_s1, @rachel.current_team
      assert @rachel.student_quizzes.empty?
      assert @rachel.destroy
      assert_nil @rachel.current_team
    end

    should "not destroy students with prior quizzes but can be made inactive" do
      # Ellie and Anna are active now
      assert @ellie.active
      assert @anna.active
      # ... and have participated in quizzes
      deny @ellie.student_quizzes.empty?
      deny @anna.student_quizzes.empty?
      # assert that Ellie has a current team assignment
      deny @ellie.student_teams.current.empty?
      # remove team assignment from Anna and confirm
      @anna.student_teams.current.first.terminate_now
      assert @anna.student_teams.current.empty?
      # attempt to destroy fails
      deny @ellie.destroy  # has current assignments
      deny @anna.destroy   # has only past assignments
      @ellie.reload
      @anna.reload
      # verify now inactive
      deny @ellie.active
      deny @anna.active
      # verify no current team assignments for Ellie
      assert @ellie.student_teams.current.empty?
    end

    should "not be made inactive for a bad edit" do
      assert @ellie.active
      @ellie.last_name = nil
      deny @ellie.valid?
      deny @ellie.save
      assert @ellie.active
    end

    should "terminate team assignments of inactive students" do
      assert_equal 1, @ellie.student_teams.current.count
      @ellie.make_inactive
      @ellie.reload
      deny @ellie.active
      assert_equal 0, @ellie.student_teams.current.count
    end

  end
end
