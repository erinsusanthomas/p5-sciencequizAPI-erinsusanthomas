require "test_helper"

class StudentTeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = FactoryBot.create(:organization)
    @user = FactoryBot.create(:user, organization: @organization)
    @student = FactoryBot.create(:student, organization: @organization)
    @team = FactoryBot.create(:team, organization: @organization, coach: @user)

  end

  test "should get new from team" do
    get new_student_team_path(team_id: @team.id)
    assert_response :success
    assert_not_nil assigns(:team)
    assert_not_nil assigns(:current_students)
  end

  test "should create student_team" do
    assert_difference('StudentTeam.count') do
      post student_teams_path, params: { student_team: { student_id: @student.id, team_id: @team.id, start_date: Date.current, position: 1 } }
    end
    assert_equal "Successfully added the student team assignment.", flash[:notice]
    assert_redirected_to team_path(StudentTeam.last.team)

    post student_teams_path, params: { student_team: { student_id: nil, team_id: @team.id, start_date: Date.current, position: 1 } }
    assert_template :new, locals: { team: @team }
  end

  test "should terminate student team assignment" do
    assert_equal 0, @team.student_teams.current.count
    @student_team = FactoryBot.create(:student_team, student: @student, team: @team, start_date: 1.week.ago.to_date, end_date: nil)
    assert_nil @student_team.end_date
    assert_equal 1, @team.student_teams.current.count
    patch terminate_student_team_path(@student_team)
    @team.reload
    @student_team.reload
    assert_equal Date.current, @student_team.end_date
    assert_equal 0, @team.student_teams.current.count
    assert_redirected_to team_path(@student_team.team)
    assert_equal "Team assignment terminated as of today.", flash[:notice]
  end

  test "should destroy student team assignment when appropriate" do
    @student_team = FactoryBot.create(:student_team, student: @student, team: @team)
    assert_difference('StudentTeam.count', -1) do
      delete remove_student_team_path(@student_team)
    end
    assert_equal "Successfully destroyed team assignment.", flash[:notice]
    assert_redirected_to team_path(@student_team.team)
  end

  test "should not have generic routes (i.e., not using resources :student_teams)" do
    @student_team = FactoryBot.create(:student_team, student: @student, team: @team)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "student_teams", action: "index") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "student_teams", action: "show", id: "#{@student_team.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "student_teams", action: "edit", id: "#{@student_team.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "student_teams", action: "update", id: "#{@student_team.id}") end
  end

end