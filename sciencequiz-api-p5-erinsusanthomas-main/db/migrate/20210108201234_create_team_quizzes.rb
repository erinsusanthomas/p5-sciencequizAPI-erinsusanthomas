class CreateTeamQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :team_quizzes do |t|
      t.references :team, foreign_key: true
      t.references :quiz, foreign_key: true
      t.integer :raw_score
      t.integer :team_points
      t.integer :position

      # t.timestamps
    end
  end
end
