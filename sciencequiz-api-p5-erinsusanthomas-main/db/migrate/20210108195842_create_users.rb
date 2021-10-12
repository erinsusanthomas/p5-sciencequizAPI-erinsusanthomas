class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :status
      t.references :organization, foreign_key: true
      t.boolean :active, default: true
      t.string :email
      t.string :phone
      t.string :password_digest
      t.string :username
      t.datetime :active_after
      t.string :reset_token
      t.datetime :reset_sent_at

      # t.timestamps
    end
  end
end
