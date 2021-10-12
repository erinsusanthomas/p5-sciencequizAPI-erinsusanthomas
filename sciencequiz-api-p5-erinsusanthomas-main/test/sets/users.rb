module Contexts
  module Users

    def create_users
      @ed      = FactoryBot.create(:user, organization: @millvale)
      @ralph   = FactoryBot.create(:user, organization: @millvale, first_name: "Ralph", last_name: "Wilson", username: "ralph", status: "leader")
      @chuck   = FactoryBot.create(:user, organization: @acac, first_name: "Chuck", last_name: "Wilson", username: "chuck", active: false)
      @cindy   = FactoryBot.create(:user, organization: @acac, first_name: "Cindy", last_name: "Crawford", username: "cindy")
      @sophie  = FactoryBot.create(:user, organization: @acac, first_name: "Sophie", last_name: "Marceau", username: "sophie")
      @ben     = FactoryBot.create(:user, organization: @acac, first_name: "Ben", last_name: "Sisko", username: "ben", status: "leader", phone: "412-268-2323", email: "ben@example.com")
      @kathryn = FactoryBot.create(:user, organization: @acac, first_name: "Kathryn", last_name: "Janeway", username: "kathryn", status: "leader")
      @alex    = FactoryBot.create(:user, organization: @sq, first_name: "Alex", username: "alex", last_name: "Heimann", status: "admin")
    end
    
    def destroy_users
      @ed.destroy
      @ralph.destroy
      @chuck.destroy
      @cindy.destroy
      @sophie.destroy
      @ben.destroy
      @kathryn.destroy
      @alex.destroy
    end

  end
end