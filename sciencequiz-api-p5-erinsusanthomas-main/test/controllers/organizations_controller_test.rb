require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = FactoryBot.create(:organization)
  end

  test "should get index" do
    get organizations_path
    assert_response :success
    assert_not_nil assigns(:active_organizations)
    assert_not_nil assigns(:inactive_organizations)
  end

  test "should get new" do
    get new_organization_path
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      post organizations_path, params: { organization: { active: true, name: "Morewood School", street_1: "101 Morewood Ave", city: "Pgh", state: "PA", zip: "15213", short_name: "Morewood" } }
    end
    assert_equal "Successfully created Morewood School.", flash[:notice]
    assert_redirected_to organization_path(Organization.last)
  end

  test "should not create invalid organization" do
    post organizations_path, params: { organization: { active: true, name: nil, street_1: "101 Morewood Ave", city: "Pgh", state: "PA", zip: "15213", short_name: "Morewood" } }
    assert_template :new
  end

  test "should show organization" do
    get organization_path(@organization)
    assert_response :success
    assert_not_nil assigns(:current_students)
    assert_not_nil assigns(:current_teams)
  end

  test "should get edit" do
    get edit_organization_path(@organization)
    assert_response :success
  end

  test "should update organization" do
    patch organization_path(@organization), params: { organization: { active: true, name: @organization.name, street_1: "101 Morewood Ave", city: @organization.city, state: @organization.state, zip: @organization.zip, short_name: @organization.short_name } }
    assert_redirected_to organization_path(@organization)
  end

  test "should not update an invalid organization" do
    patch organization_path(@organization), params: { organization: { active: true, name: nil, street_1: "101 Morewood Ave", city: @organization.city, state: @organization.state, zip: @organization.zip, short_name: @organization.short_name } }
    assert_template :edit
  end

  test "should destroy organization when appropriate" do
    assert_difference('Organization.count', -1) do
      delete organization_path(@organization)
    end
    assert_equal "Removed #{@organization.name} from the system.", flash[:notice]
    assert_redirected_to organizations_path
  end

end