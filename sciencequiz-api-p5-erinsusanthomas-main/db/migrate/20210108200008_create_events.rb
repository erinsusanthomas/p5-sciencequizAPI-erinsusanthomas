class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.date :date
      t.references :organization, foreign_key: true
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
