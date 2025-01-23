# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name,           null: false, default: ""
      t.string :last_name,            null: false, default: ""
      t.string :email,                null: false, default: ""
      t.string :encrypted_password,   null: false, default: ""
      t.datetime :remember_created_at
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
