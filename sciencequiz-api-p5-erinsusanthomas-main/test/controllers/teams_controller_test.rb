require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = FactoryBot.create(:organization)
    @user = FactoryBot.create(:user, organization: @organization)
    @team = FactoryBot.create(:team, organization: @organization, coach: @user)
  end

  test "should get index" do
    get teams_path
    assert_response :success
    assert_not_nil assigns(:active_junior_teams)
    assert_not_nil assigns(:active_senior_teams)
    assert_not_nil assigns(:inactive_teams)
  end

  test "should get new" do
    get new_team_path
    assert_response :success
  end

  test "should create team" do
    assert_difference('Team.count') do
      post teams_path, params: { team: { active: true, name: "Morewood 1", division: "junior", organization_id: @organization.id, coach_id: @user.id  } }
    end
    assert_equal "Successfully created Morewood 1 team.", flash[:notice]
    assert_redirected_to team_path(Team.last)
  end

  test "should not create invalid team" do
    post teams_path, params: { team: { active: true, name: nil, division: "junior", organization_id: @organization.id  } }
    assert_template :new
  end

  test "should show team" do
    get team_path(@team)
    assert_response :success
    assert_not_nil assigns(:current_student_assignments)
  end

  test "should get edit" do
    get edit_team_path(@team)
    assert_response :success
  end

  test "should update team" do
    patch team_path(@team), params: { team: { active: true, name: "Morewood 1", division: @team.division, organization_id: @team.organization.id, coach_id: @user.id  } }
    assert_redirected_to team_path(@team)
  end

  test "should not update an invalid team" do
    patch team_path(@team), params: { team: { active: true, name: nil, division: @team.division, organization_id: @team.organization.id, coach_id: @user.id  } }
    assert_template :edit
  end

  test "should destroy team when appropriate" do
    assert_difference('Team.count', -1) do
      delete team_path(@team)
    end
    assert_equal "Removed #{@team.name} from the system.", flash[:notice]
    assert_redirected_to teams_path
  end

end