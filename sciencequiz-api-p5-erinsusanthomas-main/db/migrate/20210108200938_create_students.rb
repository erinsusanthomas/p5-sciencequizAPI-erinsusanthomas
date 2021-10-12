class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :grade
      t.references :organization, foreign_key: true
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
