require "test_helper"

class EventScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_organizations
      create_events
    end

    should "list events chronologically" do
      assert_equal [@acac_e2, @acac_e1, @millvale_e1, @acac_e3, @uniontown_e1], Event.chronological
    end

    should "list active events" do
      assert_equal [@acac_e2, @acac_e1, @millvale_e1, @acac_e3], Event.active.sort_by{|e| e.date}
    end

    should "list inactive events" do
      assert_equal [@uniontown_e1], Event.inactive
    end

    should "list events for a given organization" do
      assert_equal [@acac_e2, @acac_e1, @acac_e3], Event.for_organization(@acac).sort_by{|e| e.date}
      assert_equal [@millvale_e1], Event.for_organization(@millvale)
    end

    should "list upcoming events" do
      assert_equal [@acac_e3, @uniontown_e1], Event.upcoming
    end    

    should "list past events" do
      assert_equal [@acac_e2, @acac_e1, @millvale_e1], Event.past.sort_by{|e| e.date}
    end 

  end
end