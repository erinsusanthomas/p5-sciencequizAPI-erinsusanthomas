module Contexts
  module Quizzes

    def create_quizzes

      @acac_e1_s1_r1 = FactoryBot.create(:quiz, event: @acac_e1, division: 'senior', room: 1, round: 1)
      @acac_e1_s2_r1 = FactoryBot.create(:quiz, event: @acac_e1, division: 'senior', room: 2, round: 1)
      @acac_e1_s1_r2 = FactoryBot.create(:quiz, event: @acac_e1, division: 'senior', room: 1, round: 2)
      @acac_e1_s2_r2 = FactoryBot.create(:quiz, event: @acac_e1, division: 'senior', room: 2, round: 2)

      @acac_e1_j3_r1 = FactoryBot.create(:quiz, event: @acac_e1, division: 'junior', room: 3, round: 1)
      @acac_e1_j4_r1 = FactoryBot.create(:quiz, event: @acac_e1, division: 'junior', room: 4, round: 1)
      @acac_e1_j3_r2 = FactoryBot.create(:quiz, event: @acac_e1, division: 'junior', room: 3, round: 2)
      @acac_e1_j4_r2 = FactoryBot.create(:quiz, event: @acac_e1, division: 'junior', room: 4, round: 2)

      @acac_e3_s1_r1 = FactoryBot.create(:quiz, event: @acac_e3, division: 'senior', room: 1, round: 1)
      @acac_e3_s2_r1 = FactoryBot.create(:quiz, event: @acac_e3, division: 'senior', room: 2, round: 1)
      @acac_e3_s1_r2 = FactoryBot.create(:quiz, event: @acac_e3, division: 'senior', room: 1, round: 2)
      @acac_e3_s2_r2 = FactoryBot.create(:quiz, event: @acac_e3, division: 'senior', room: 2, round: 2)
      
    end
    
    def destroy_quizzes
      @acac_e1_s1_r1.destroy
      @acac_e1_s2_r1.destroy
      @acac_e1_s1_r2.destroy
      @acac_e1_s2_r2.destroy
      @acac_e1_j3_r1.destroy
      @acac_e1_j4_r1.destroy
      @acac_e1_j3_r2.destroy
      @acac_e1_j4_r2.destroy
      @acac_e2_s1_r1.destroy
      @acac_e2_s2_r1.destroy
      @acac_e2_s1_r2.destroy
      @acac_e2_s2_r2.destroy
      
    end

  end
end