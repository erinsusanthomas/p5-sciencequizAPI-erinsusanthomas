module Contexts
  module Events

    def create_events
      @acac_e1      = FactoryBot.create(:event, organization: @acac)
      @acac_e2      = FactoryBot.create(:event, organization: @acac, date: 2.months.ago.to_date)
      @acac_e3      = FactoryBot.create(:event, organization: @acac, date: Date.current)
      @millvale_e1  = FactoryBot.create(:event, organization: @millvale, date: 1.week.ago.to_date)
      @uniontown_e1 = FactoryBot.create(:event, organization: @uniontown, date: 1.month.from_now.to_date, active: false)
    end
    
    def destroy_events
      @acac_e1.destroy 
      @acac_e2.destroy
      @acac_e3.destroy
      @millvale_e1.destroy 
      @uniontown_e1.destroy 
    end

  end
end