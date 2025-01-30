class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string  :title, null: false
      t.text    :description
      t.integer :status, default: 0
      t.references :assignee, foreign_key: { to_table: :users }
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
