module Contexts
  module StudentTeams

    def create_student_teams
      @ellie_t1 = FactoryBot.create(:student_team, student: @ellie, team: @acac_s1, start_date: 20.weeks.ago.to_date, position: 1)
      @anna_t1 = FactoryBot.create(:student_team, student: @anna, team: @acac_s1, start_date: 19.weeks.ago.to_date, position: 2)
      # @sarah_t1 = FactoryBot.create(:student_team, student: @sarah, team: @acac_s1, start_date: 5.months.ago.to_date, end_date: 3.months.ago.to_date, position: 3)

      @mason_t1 = FactoryBot.create(:student_team, student: @mason, team: @millvale_j1, start_date: 16.weeks.ago.to_date, position: 2)
      @mj_t1 = FactoryBot.create(:student_team, student: @mj, team: @millvale_j1, start_date: 17.weeks.ago.to_date, position: 1)
      @amelia_t1 = FactoryBot.create(:student_team, student: @amelia, team: @millvale_j1, start_date: 15.weeks.ago.to_date, position: 3, active: false)
    end

    def create_more_student_teams
      @lydia_t1 = FactoryBot.create(:student_team, student: @lydia, team: @acac_s2, start_date: 5.months.ago.to_date, position: 1)
      @sarah_t2 = FactoryBot.create(:student_team, student: @sarah, team: @acac_s2, start_date: 3.months.ago.to_date, position: 2)

      @leila_t1 = FactoryBot.create(:student_team, student: @leila, team: @acac_s3, start_date: 5.months.ago.to_date, position: 1)
      @newton_t1 = FactoryBot.create(:student_team, student: @newton, team: @acac_s3, start_date: 5.months.ago.to_date, position: 2)

      @miles_t1 = FactoryBot.create(:student_team, student: @miles, team: @acac_j1, start_date: 5.months.ago.to_date, position: 1)
      @caleb_t1 = FactoryBot.create(:student_team, student: @caleb, team: @acac_j1, start_date: 5.months.ago.to_date, position: 2)
      @jacob_t1 = FactoryBot.create(:student_team, student: @jacob, team: @acac_j1, start_date: Date.new(2020,10,9), end_date: nil, position: 3)
      @naaman_t1 = FactoryBot.create(:student_team, student: @naaman, team: @acac_j1, start_date: 2.months.ago.to_date, position: 3)

      @noah_t1 = FactoryBot.create(:student_team, student: @noah, team: @acac_j2, start_date: 5.months.ago.to_date, position: 1)
      @nathan_t1 = FactoryBot.create(:student_team, student: @nathan, team: @acac_j2, start_date: 5.months.ago.to_date, position: 2)
      @jacob_t2 = FactoryBot.create(:student_team, student: @jacob, team: @acac_j2, start_date: Date.new(2021,1,15), position: 4)
      @naaman_t2 = FactoryBot.create(:student_team, student: @naaman, team: @acac_j2, start_date: 5.months.ago.to_date, end_date: 2.months.ago.to_date, position: 4)
      @micah_t1 = FactoryBot.create(:student_team, student: @micah, team: @acac_j2, start_date: 2.months.ago.to_date, position: 3)

      @cana_t1 = FactoryBot.create(:student_team, student: @miles, team: @acac_j3, start_date: 5.months.ago.to_date, position: 1)
      @taylor_t1 = FactoryBot.create(:student_team, student: @taylor, team: @acac_j3, start_date: 5.months.ago.to_date, position: 2)
      @didi_t1 = FactoryBot.create(:student_team, student: @didi, team: @acac_j3, start_date: 5.months.ago.to_date, position: 3)
    end

      
    def destroy_student_teams
      @ellie_t1.destroy
      @anna_t1.destroy
      @sarah_t1.destroy
      @mj_t1.destroy
      @mason_t1.destroy
      @amelia_t1.destroy
    end

    def destroy_more_student_teams
      @lydia_t1.destroy
      @sarah_t2.destroy
      @leila_t1.destroy
      @newton_t1.destroy
      @miles_t1.destroy
      @caleb_t1.destroy
      @jacob_t1.destroy
      @naaman_t1.destroy
      @noah_t1.destroy
      @nathan_t1.destroy
      @jacob_t2.destroy
      @naaman_t2.destroy
      @micah_t1.destroy
      @cana_t1.destroy
      @taylor_t1.destroy
      @didi_t1.destroy
    end

  end
end