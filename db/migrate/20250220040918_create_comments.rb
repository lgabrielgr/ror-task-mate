class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.boolean :edited, null: false, default: false
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :ticket, null: false, foreign_key: true
      t.timestamps
    end
  end
end
