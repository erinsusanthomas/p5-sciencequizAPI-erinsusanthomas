require 'test_helper'

### NOTE: I have aliased :edit, :update, :destroy to :modify in my ability.rb file and use that below
### See https://github.com/CanCanCommunity/cancancan/wiki/Action-Aliases

class AbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of admin users to do everything" do
      create_admin_abilities
      assert @alex_ability.can? :manage, :all
    end

    should "verify the abilities of organizational leaders" do
      create_leader_abilities
      # no global privileges
      deny @kathryn_ability.can? :manage, :all
      # testing particular abilities
      assert @kathryn_ability.can? :read, :all
      assert @kathryn_ability.can? :create, User
      assert @kathryn_ability.can? :create, Team
      assert @kathryn_ability.can? :create, StudentTeam
      deny @kathryn_ability.can? :create, Organization
      deny @kathryn_ability.can? :create, Event
      deny @kathryn_ability.can? :create, Quiz
      assert @kathryn_ability.can? :modify, @acac       # ACAC organization
      deny @kathryn_ability.can? :modify, @millvale     # Millvale organization      
      assert @kathryn_ability.can? :modify, @sophie     # ACAC person
      deny @kathryn_ability.can? :modify, @ralph        # Millvale person
      assert @kathryn_ability.can? :modify, @acac_s1    # ACAC team
      deny @kathryn_ability.can? :modify, @millvale_j1  # Millvale team
      assert @kathryn_ability.can? :modify, @ellie_t1   # ACAC student-team
      deny @kathryn_ability.can? :modify, @mason_t1     # Millvale student-team
    end

    should "verify the abilities of coaches" do
      create_coach_abilities
      # no global privileges
      deny @sophie_ability.can? :manage, :all
      # testing particular abilities
      deny @sophie_ability.can? :read, :all
      deny @sophie_ability.can? :create, :all
      assert @sophie_ability.can? :index, Team
      assert @sophie_ability.can? :index, Student
      assert @sophie_ability.can? :index, Organization
      assert @sophie_ability.can? :show, @acac
      deny @sophie_ability.can? :show, @millvale
      assert @sophie_ability.can? :index, Event
      assert @sophie_ability.can? :show, Event
      assert @sophie_ability.can? :index, Quiz
      assert @sophie_ability.can? :show, Quiz
      assert @sophie_ability.can? :show, @ellie
      assert @sophie_ability.can? :show, @rachel
      deny @sophie_ability.can? :show, @mason
      assert @sophie_ability.can? :modify, @ellie
      deny @sophie_ability.can? :modify, @rachel
      deny @sophie_ability.can? :modify, @mason
      assert @sophie_ability.can? :update, @ellie_t1
      deny @sophie_ability.can? :update, @mason_t1 
    end
  end
end