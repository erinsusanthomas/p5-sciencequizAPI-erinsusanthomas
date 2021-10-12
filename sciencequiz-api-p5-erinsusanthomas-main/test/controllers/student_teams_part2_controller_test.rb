require "test_helper"

class StudentTeamsControllerPart2Test < ActionDispatch::IntegrationTest
  setup do
    @organization = FactoryBot.create(:organization)
    @user = FactoryBot.create(:user, organization: @organization)
    @student = FactoryBot.create(:student, organization: @organization)
    @team = FactoryBot.create(:team, organization: @organization, coach: @user)
  end

  test "should get new from student" do
    student_team = FactoryBot.create(:student_team, student: @student, team: @team)
    get new_student_team_path(student_id: @student.id)
    assert_response :success
    assert_not_nil assigns(:student)
    assert_not_nil assigns(:current_team)
  end

end