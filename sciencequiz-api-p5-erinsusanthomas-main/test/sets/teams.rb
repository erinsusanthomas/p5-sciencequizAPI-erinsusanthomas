module Contexts
  module Teams

    def create_teams
      @acac_s1     = FactoryBot.create(:team, organization: @acac, coach: @sophie)
      @millvale_j1 = FactoryBot.create(:team, organization: @millvale, name: 'Millvale 1', division: 'junior', coach: @ed)
      @acac_s4     = FactoryBot.create(:team, organization: @acac, name: 'ACAC 4', active: false, coach: @sophie)
    end

    def create_more_teams
      @acac_s2 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 2', division: 'senior', coach: @ben)
      @acac_s3 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 3', division: 'senior', coach: @ben)
      @acac_j1 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 1', division: 'junior', coach: @ben)
      @acac_j2 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 2', division: 'junior', coach: @cindy)
      @acac_j3 = FactoryBot.create(:team, organization: @acac, name: 'ACAC 3', division: 'junior', coach: @cindy)
    end

    def destroy_teams
      @acac_s1.destroy
      @acac_s4.destroy
      @millvale_j1.destroy
    end

    def destroy_more_teams
      @acac_s2.destroy
      @acac_s3.destroy
      @acac_j1.destroy
      @acac_j2.destroy
      @acac_j3.destroy
    end

  end
end