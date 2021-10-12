class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.references :event, foreign_key: true
      t.string :division
      t.integer :room
      t.integer :round

      # t.timestamps
    end
  end
end
