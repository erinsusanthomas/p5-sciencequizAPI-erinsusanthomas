class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :organization, foreign_key: true
      t.string :division
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
