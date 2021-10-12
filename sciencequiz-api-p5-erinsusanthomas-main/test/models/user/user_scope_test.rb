require "test_helper"

class UserScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_organizations
      create_users
    end

    should "list users alphabetically" do
      assert_equal [@cindy, @ed, @alex, @kathryn, @sophie, @ben, @chuck, @ralph], User.alphabetical
    end

    should "list active users" do
      assert_equal 7, User.active.count
      assert_equal [@cindy, @ed, @alex, @kathryn, @sophie, @ben, @ralph], User.active.sort_by{|c| c.last_name}
    end

    should "list inactive users" do
      assert_equal 1, User.inactive.count
      assert_equal [@chuck], User.inactive
    end

  end
end