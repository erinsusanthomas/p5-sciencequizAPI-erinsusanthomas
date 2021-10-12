require 'test_helper'

class UserDeletionTest < ActiveSupport::TestCase

  context "Within context" do
    setup do
      create_organizations
      create_users
    end

    should "not be able destroy users regardless of status" do
      deny @alex.destroy    # the admin
      deny @ralph.destroy   # the leader
      deny @sophie.destroy  # the coach
      deny @chuck.destroy   # the inactive user
    end
  end

end