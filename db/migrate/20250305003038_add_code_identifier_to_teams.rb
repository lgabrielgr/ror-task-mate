class AddCodeIdentifierToTeams < ActiveRecord::Migration[8.0]
  def change
    add_column :teams, :code_identifier, :string, null: false
  end
end
