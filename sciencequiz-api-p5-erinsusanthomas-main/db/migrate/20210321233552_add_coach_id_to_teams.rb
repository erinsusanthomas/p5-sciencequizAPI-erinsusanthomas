class AddCoachIdToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :coach_id, :integer
  end
end
