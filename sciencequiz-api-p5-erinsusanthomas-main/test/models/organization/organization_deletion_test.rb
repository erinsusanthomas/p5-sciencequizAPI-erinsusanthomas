require 'test_helper'

class OrganizationDeletionTest < ActiveSupport::TestCase

  context "Within context" do
    setup do
      create_organizations
    end

    should "not be able destroy organizations for any reason" do
      deny @millvale.destroy    # the active one
      deny @cinderlands.destroy # the inactive one
      deny @sq.destroy          # the headquarters
    end
  end

end