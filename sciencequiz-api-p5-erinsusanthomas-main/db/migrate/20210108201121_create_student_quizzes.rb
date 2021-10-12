class CreateStudentQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_quizzes do |t|
      t.references :student, foreign_key: true
      t.references :quiz, foreign_key: true
      t.integer :score
      t.integer :num_attempted
      t.integer :num_correct

      # t.timestamps
    end
  end
end
