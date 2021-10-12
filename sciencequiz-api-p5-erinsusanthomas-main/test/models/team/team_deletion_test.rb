require 'test_helper'

class TeamDeletionTest < ActiveSupport::TestCase

  context "Within context" do
    setup do
      create_organizations
      create_users
      create_teams
    end

    should "not be able destroy teams that have participated in a quiz" do
      create_events
      create_quizzes
      create_team_quizzes
      deny @acac_s1.destroy  
    end

    should "be able destroy teams that have never participated in a quiz" do
      # an inactive that has never quizzed
      assert @acac_s4.destroy
      # since we have not created any quizzes in this test, this will also work:
      assert @acac_s1.destroy
    end
  end

end