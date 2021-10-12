module Contexts
  module StudentQuizzes

    def create_student_quizzes
      @ellie_acac_e1_s1_r1 = FactoryBot.create(:student_quiz, student: @ellie, quiz: @acac_e1_s1_r1, num_attempted: 4, num_correct: 4)
      @anna_acac_e1_s1_r1 = FactoryBot.create(:student_quiz, student: @anna, quiz: @acac_e1_s1_r1, num_attempted: 4, num_correct: 2)
      @ellie_acac_e1_s1_r2 = FactoryBot.create(:student_quiz, student: @ellie, quiz: @acac_e1_s2_r2, num_attempted: 5, num_correct: 4)
      @anna_acac_e1_s1_r2 = FactoryBot.create(:student_quiz, student: @anna, quiz: @acac_e1_s2_r2, num_attempted: 0, num_correct: 0)

      @mj_acac_e1_j3_r1 = FactoryBot.create(:student_quiz, student: @mj, quiz: @acac_e1_j3_r1, num_attempted: 5, num_correct: 2)
      @mason_acac_e1_j3_r1 = FactoryBot.create(:student_quiz, student: @mason, quiz: @acac_e1_j3_r1, num_attempted: 1, num_correct: 1)
      @amelia_acac_e1_j3_r1 = FactoryBot.create(:student_quiz, student: @amelia, quiz: @acac_e1_j3_r1, num_attempted: 0, num_correct: 0)
      @mj_acac_e1_j4_r2 = FactoryBot.create(:student_quiz, student: @mj, quiz: @acac_e1_j4_r2, num_attempted: 6, num_correct: 4)
      @mason_acac_e1_j4_r2 = FactoryBot.create(:student_quiz, student: @mason, quiz: @acac_e1_j4_r2, num_attempted: 1, num_correct: 1)
      @amelia_acac_e1_j4_r2 = FactoryBot.create(:student_quiz, student: @amelia, quiz: @acac_e1_j4_r2, num_attempted: 0, num_correct: 0)
    end

    def create_more_student_quizzes
      

    end
        
    def destroy_student_quizzes
      @ellie_acac_e1_s1_1.destroy
      @anna_acac_e1_s1_1.destroy
      @ellie_acac_e1_s1_1.destroy
      @anna_acac_e1_s1_1.destroy
      @mj_acac_e1_j1_1.destroy
      @mason_acac_e1_j1_1.destroy
      @amelia_acac_e1_j1_1.destroy
      @mj_acac_e1_j2_1.destroy
      @mason_acac_e1_j2_1.destroy
      @amelia_acac_e1_j2_1.destroy
    end

    def destroy_more_student_quizzes
      

    end

  end
end