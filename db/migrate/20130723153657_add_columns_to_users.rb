class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :name, :string
  end
end
