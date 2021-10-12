require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:organization)
  should have_many(:student_teams)
  should have_many(:teams).through(:student_teams)
  should have_many(:student_quizzes)
  should have_many(:quizzes).through(:student_quizzes)

  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:grade)
  should validate_presence_of(:organization_id)

  should validate_numericality_of(:grade).only_integer.is_greater_than(2).is_less_than(13)
  should allow_value(12).for(:grade)
  should_not allow_value(10.5).for(:grade)
  should_not allow_value(-4).for(:grade)
  should_not allow_value("bad").for(:grade)
  should_not allow_value(nil).for(:grade)

  # Context
  context "Given context" do
    setup do 
      create_organizations
      create_students
    end

    should "list students alphabetically" do
      assert_equal [@anna, @rachel, @mason, @mj, @amelia, @ellie], Student.alphabetical
    end

    should "list active students" do
      assert_equal 5, Student.active.count
      assert_equal [@anna, @mason, @mj, @amelia, @ellie], Student.active.sort_by{|s| s.last_name}
    end

    should "list inactive students" do
      assert_equal 1, Student.inactive.count
      assert_equal [@rachel], Student.inactive
    end

    should "list junior students" do
      assert_equal 3, Student.juniors.count
      assert_equal [@mason, @mj, @amelia], Student.juniors.sort_by{|s| s.last_name}
    end

    should "list senior students" do
      assert_equal 3, Student.seniors.count
      assert_equal [@anna, @rachel, @ellie], Student.seniors.sort_by{|s| s.last_name}
    end

    should "list students for a given organization" do
      assert_equal [@mason, @mj, @amelia], Student.for_organization(@millvale).sort_by{|s| s.last_name}
    end

    should "have a make_active method" do
      deny @rachel.active
      @rachel.make_active
      @rachel.reload
      assert @rachel.active
    end

    should "have a make_inactive method" do
      assert @ellie.active
      @ellie.make_inactive
      @ellie.reload
      deny @ellie.active
    end

    should "identify a non-active organization as part of an invalid student" do
      inactive_org = FactoryBot.create(:organization, name: "ghost", short_name: "ghost", active: false)
      invalid_student = FactoryBot.build(:student, organization: inactive_org, first_name: "ghost")
      deny invalid_student.valid?
    end

    should "identify a non-existent organization as part of an invalid student" do
      ghost_org = FactoryBot.build(:organization, name: "ghost", short_name: "ghost", active: true)
      invalid_student = FactoryBot.build(:student, organization: ghost_org, first_name: "ghost")
      deny invalid_student.valid?
    end

    should "allow an existing student to still be updated if organization is inactive" do
      assert @ellie.valid?
      @acac.make_inactive
      @acac.reload
      @ellie.reload
      deny @acac.active?
      assert @ellie.valid?
      # try updating the first name of the student 
      @ellie.first_name = "Ellie!"
      assert @ellie.save
    end

    should "shows name as last, first name" do
      assert_equal "Davis, Anna", @anna.name
    end   
    
    should "shows proper name as first and last name" do
      assert_equal "Anna Davis", @anna.proper_name
    end 

    should "distinguish between junior and senior students" do
      deny @anna.junior?
      assert @mason.junior?
    end

    should "shows return student's current team, given it exists" do
      create_users
      create_teams
      create_student_teams
      assert_equal @acac_s1, @anna.current_team
    end

    should "shows return nil for student's current team, if doesn't exist" do
      create_users
      create_teams
      create_student_teams
      # terminate Anna's team assignment
      @anna_t1.end_date = 1.day.ago.to_date
      @anna_t1.save
      @anna.reload
      # verify current team is nil
      assert_nil @anna.current_team
      # now confirm with someone never on a team
      assert_nil @rachel.current_team
    end

    should "shows return student's current team, given multiple teams" do
      create_users
      create_teams
      create_student_teams
      @acac_s4.make_active
      @anna_t1.end_date = 1.day.ago.to_date
      @anna_t1.save
      @anna_t4 = FactoryBot.create(:student_team, student: @anna, team: @acac_s4, start_date: 1.day.ago.to_date, position: 1)
      @anna.reload
      # verify current team is now ACAC 4, not ACAC 1
      assert_equal @acac_s4, @anna.current_team
    end

  end
end
