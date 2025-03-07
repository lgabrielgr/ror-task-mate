class AddCodeIdentifierToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :code_identifier, :string, null: false
  end
end
