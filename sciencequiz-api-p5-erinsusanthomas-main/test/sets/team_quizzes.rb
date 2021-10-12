module Contexts
    module TeamQuizzes

        def create_team_quizzes
          @acac_s1_e1_s1_r1 = FactoryBot.create(:team_quiz, team: @acac_s1, quiz: @acac_e1_s1_r1, raw_score: 120, team_points: 12, position: 2)
          @acac_s1_e1_s2_r2 = FactoryBot.create(:team_quiz, team: @acac_s1, quiz: @acac_e1_s2_r2, raw_score: 90, team_points: 8, position: 1)

          @acac_s1_e3_s1_r2 = FactoryBot.create(:team_quiz, team: @acac_s1, quiz: @acac_e3_s1_r2, position: 2)
          @acac_s1_e3_s2_r1 = FactoryBot.create(:team_quiz, team: @acac_s1, quiz: @acac_e3_s2_r1, position: 3)

          @millvale_j1_e1_j3_r1 = FactoryBot.create(:team_quiz, team: @millvale_j1, quiz: @acac_e1_j3_r1, raw_score: 40, team_points: 2, position: 3)
          @millvale_j1_e1_j4_r2 = FactoryBot.create(:team_quiz, team: @millvale_j1, quiz: @acac_e1_j4_r2, raw_score: 90, team_points: 10, position: 1)
        end

        def destroy_team_quizzes
          @acac_s1_e1_s1_r1.destroy
          @acac_s1_e1_s2_r2.destroy
          @acac_s1_e3_s1_r2.destroy
          @acac_s1_e3_s2_r1.destroy
          @millvale_j1_e1_j3_r1.destroy
          @millvale_j1_e1_j4_r2.destroy
        end
        
    end
end
