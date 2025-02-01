class AddDueDateAndPriorityToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :due_date, :date
    add_column :tickets, :priority, :integer
  end
end
