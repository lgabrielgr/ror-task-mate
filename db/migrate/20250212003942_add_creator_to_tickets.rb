class AddCreatorToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :creator_id, :integer, null: false
    add_foreign_key :tickets, :users, column: :creator_id
  end
end
