class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :short_name
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
