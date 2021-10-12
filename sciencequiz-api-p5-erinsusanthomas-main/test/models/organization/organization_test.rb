require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  # Matchers
  should have_many(:students)
  should have_many(:teams)
  should have_many(:student_teams).through(:teams)
  should have_many(:users)

  should validate_presence_of(:name)
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_presence_of(:short_name)

  TEST_STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  should validate_inclusion_of(:state).in_array(TEST_STATES).allow_blank
  should allow_value(nil).for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value(10).for(:state)
  should_not allow_value("EU").for(:state)

  should validate_uniqueness_of(:short_name).case_insensitive

  should allow_value("03431").for(:zip)
  should allow_value("15213").for(:zip)
  should allow_value("15090").for(:zip)
  should_not allow_value("terri").for(:zip)
  should_not allow_value("3431").for(:zip)
  should_not allow_value("343101").for(:zip)
  should_not allow_value("15d32").for(:zip)

  # Context
  context "Given context" do
    setup do 
      create_organizations
    end

    should "list organizations alphabetically" do
      assert_equal ['Allegheny Center Alliance', 'Cinderlands Alliance', 'Millvale Alliance', 'ScienceQuiz', 'Uniontown Alliance'], Organization.alphabetical.map{|o| o.name}
    end

    should "list active organizations" do
      assert_equal 4, Organization.active.count
      assert_equal ['Allegheny Center Alliance', 'Millvale Alliance', 'ScienceQuiz', 'Uniontown Alliance'], Organization.active.map{|o| o.name}.sort
      assert_equal [@acac, @millvale, @sq, @uniontown], Organization.active.sort_by{|o| o.name}
    end

    should "list inactive organizations" do
      assert_equal 1, Organization.inactive.count
      assert_equal [@cinderlands], Organization.inactive
    end

    should "have a make_active method" do
      deny @cinderlands.active
      @cinderlands.make_active
      @cinderlands.reload
      assert @cinderlands.active
    end

    should "have a make_inactive method" do
      assert @acac.active
      @acac.make_inactive
      @acac.reload
      deny @acac.active
    end

  end
end