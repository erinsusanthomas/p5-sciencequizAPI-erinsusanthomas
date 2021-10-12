module Contexts
  module Organizations

    def create_organizations
      @millvale    = FactoryBot.create(:organization)
      @uniontown   = FactoryBot.create(:organization, name: "Uniontown Alliance", short_name: "Uniontown", street_1: "123 Matthew Dr", city: "Uniontown", zip: "15401")
      @cinderlands = FactoryBot.create(:organization, name: "Cinderlands Alliance", short_name: "Cinder", street_1: "2601 Smallman St", city: "Pittsburgh", zip: "15222", active: false)
      @acac        = FactoryBot.create(:organization, name: "Allegheny Center Alliance", short_name: "ACAC", street_1: "250 East Ohio St", city: "Pittsburgh", zip: "15212")
      @sq          = FactoryBot.create(:organization, name: "ScienceQuiz", short_name: "SQ", street_1: "10152 Sudberry Dr", city: "Wexford", zip: "15090")
      # change created_at so diff values in views, cuke testing...
      @acac.created_at = 1.year.ago.to_date
      @acac.save
    end
    
    def destroy_organizations
      @millvale.destroy
      @uniontown.destroy
      @cinderlands.destroy
      @acac.destroy
      @sq.destroy
    end

  end
end