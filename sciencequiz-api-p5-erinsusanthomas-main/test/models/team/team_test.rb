require "test_helper"

class TeamTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:organization)
  should have_many(:student_teams)
  should have_many(:students).through(:student_teams)
  should have_many(:team_quizzes)
  should have_many(:quizzes).through(:team_quizzes)
  should belong_to(:coach).class_name("User")

  should validate_presence_of(:name)
  should validate_presence_of(:division)
  should validate_presence_of(:organization_id)

  should validate_inclusion_of(:division).in_array(["senior", "junior"])

  # Context
  context "Given context" do
    setup do 
      create_organizations
      create_users
      create_teams
    end

    should "list teams alphabetically" do
      assert_equal ['ACAC 1', 'ACAC 4', 'Millvale 1'], Team.alphabetical.map{|t| t.name}
    end

    should "list teams by division" do
      assert_equal ['Millvale 1', 'ACAC 1', 'ACAC 4'], Team.by_division.map{|t| t.name}
    end

    should "list active teams" do
      assert_equal 2, Team.active.count
      assert_equal ['ACAC 1', 'Millvale 1'], Team.active.map{|t| t.name}.sort
      assert_equal [@acac_s1, @millvale_j1], Team.active.sort_by{|t| t.name}
    end

    should "list inactive teams" do
      assert_equal 1, Team.inactive.count
      assert_equal [@acac_s4], Team.inactive
    end

    should "have a make_active method" do
      deny @acac_s4.active
      @acac_s4.make_active
      @acac_s4.reload
      assert @acac_s4.active
    end

    should "have a make_inactive method" do
      assert @acac_s1.active
      @acac_s1.make_inactive
      @acac_s1.reload
      deny @acac_s1.active
    end

    should "list junior teams" do
      assert_equal 1, Team.juniors.count
      assert_equal [@millvale_j1], Team.juniors
    end

    should "list seniors teams" do
      assert_equal 2, Team.seniors.count
      assert_equal [@acac_s1, @acac_s4], Team.seniors.sort_by{|t| t.name}
    end

    should "list teams for a given organization" do
      assert_equal 1, Team.for_organization(@millvale).count
      assert_equal [@millvale_j1], Team.for_organization(@millvale)
    end

    should "distinguish between junior and senior teams" do
      deny @acac_s1.junior?
      assert @millvale_j1.junior?
    end

    should "identify a non-active organization as part of an invalid team" do
      inactive_org = FactoryBot.create(:organization, name: "ghost", short_name: "ghost", active: false)
      invalid_team = FactoryBot.build(:team, organization: inactive_org, name: "ghost team", coach: @ben)
      deny invalid_team.valid?
    end

    should "identify a non-existent organization as part of an invalid team" do
      ghost_org = FactoryBot.build(:organization, name: "ghost", short_name: "ghost", active: true)
      invalid_team = FactoryBot.build(:team, organization: ghost_org, name: "ghost team", coach: @ben)
      deny invalid_team.valid?
    end

    should "allow an existing team to still be updated if organization is inactive" do
      assert @acac_s1.valid?
      @acac.make_inactive
      @acac.reload
      @acac_s1.reload
      deny @acac.active?
      assert @acac_s1.valid?
      # try updating the name of the team 
      @acac_s1.name = "ACAC S1"
      assert @acac_s1.save
    end

  end

end