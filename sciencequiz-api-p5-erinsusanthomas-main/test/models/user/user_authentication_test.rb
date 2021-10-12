require 'test_helper'

class UserAuthenticationTest < ActiveSupport::TestCase

  # Context
  context "Within context" do
    setup do
      create_organizations
      create_users
    end

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "ralph", @ralph.username
      @ralph.username = "chuck"
      deny @ralph.valid?, "UN: #{@ralph.username}"
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, organization: @sq, first_name: "Mark", username: "mark", last_name: "Heimann", status: "admin", password: nil)
      deny bad_user.valid?
    end

    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:user, organization: @sq, first_name: "Mark", username: "mark", last_name: "Heimann", status: "admin", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, organization: @sq, first_name: "Mark", username: "mark", last_name: "Heimann", status: "admin", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end

    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:user, organization: @sq, first_name: "Mark", username: "mark", last_name: "Heimann", status: "admin", password: "bad", password_confirmation: "bad")
      deny bad_user.valid?
    end

    should "have class method to handle authentication services" do
      assert User.authenticate('alex', 'secret')
      deny User.authenticate('alex', 'notsecret')
    end

    should "have role methods and recognize all three roles" do
      assert @alex.role?(:admin)
      deny @alex.role?(:leader)
      deny @alex.role?(:coach)
      deny @ralph.role?(:admin)
      assert @ralph.role?(:leader)
      deny @ralph.role?(:coach)
      deny @sophie.role?(:admin)
      deny @sophie.role?(:leader)
      assert @sophie.role?(:coach)
    end

  end
end
