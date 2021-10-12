require "test_helper"

class UserTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_organizations
      create_users
    end

    should "have a make_active method" do
      deny @chuck.active
      @chuck.make_active
      @chuck.reload
      assert @chuck.active
    end

    should "have a make_inactive method" do
      assert @ed.active
      @ed.make_inactive
      @ed.reload
      deny @ed.active
    end

    should "shows name as last, first name" do
      assert_equal "Wilson, Ralph", @ralph.name
    end   
    
    should "shows proper name as first and last name" do
      assert_equal "Ralph Wilson", @ralph.proper_name
    end 

  end
end