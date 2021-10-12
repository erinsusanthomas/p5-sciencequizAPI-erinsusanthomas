require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = FactoryBot.create(:organization)
    @student = FactoryBot.create(:student, organization: @organization)
  end

  test "should get index" do
    get students_path
    assert_response :success
    assert_not_nil assigns(:active_students)
    assert_not_nil assigns(:inactive_students)
  end

  test "should get new" do
    get new_student_path
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post students_path, params: { student: { active: true, first_name: "Ted", last_name: "Gruberman", grade: 3, organization_id: @organization.id  } }
    end
    assert_equal "Successfully created Ted Gruberman.", flash[:notice]
    assert_redirected_to student_path(Student.last)
  end

  test "should not create invalid student" do
    post students_path, params: { student: { active: true, first_name: nil, last_name: "Gruberman", grade: 3, organization_id: @organization.id  } }
    assert_template :new
  end

  test "should show student" do
    @user = FactoryBot.create(:user, organization: @organization)
    @team = FactoryBot.create(:team, organization: @organization, coach: @user)
    @student_team = FactoryBot.create(:student_team, student: @student, team: @team)
    get student_path(@student)
    assert_response :success
    assert_not_nil assigns(:current_team)
  end

  test "should get edit" do
    get edit_student_path(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_path(@student), params: { student: { active: true, first_name: @student.first_name, last_name: @student.last_name, grade: 12, organization_id: @organization.id  } }
    assert_redirected_to student_path(@student)
  end

  test "should not update an invalid student" do
    patch student_path(@student), params: { student: { active: true, first_name: @student.first_name, last_name: @student.last_name, grade: nil, organization_id: @organization.id  } }
    assert_template :edit
  end

  test "should destroy student when appropriate" do
    assert_difference('Student.count', -1) do
      delete student_path(@student)
    end
    assert_equal "Removed #{@student.proper_name} from the system.", flash[:notice]
    assert_redirected_to students_path
  end

end