require "test_helper"

class UserCallbackTest < ActiveSupport::TestCase

    context "Given context" do
      setup do 
        create_organizations
        create_users
      end
  
      should "remove non-digits from phone numbers" do
        assert_equal "4122682323", @ben.phone
      end

    end
end