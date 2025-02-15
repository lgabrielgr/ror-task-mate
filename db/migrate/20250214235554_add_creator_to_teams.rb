class AddCreatorToTeams < ActiveRecord::Migration[8.0]
  def change
    add_column :teams, :creator_id, :integer, null: false
    add_foreign_key :teams, :users, column: :creator_id
  end
end
