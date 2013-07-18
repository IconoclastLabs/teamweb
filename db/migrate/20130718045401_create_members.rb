class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user, index: true
      t.references :organization, index: true
      t.references :event, index: true
      t.references :team, index: true
      t.boolean :admin

      t.timestamps
    end
  end
end
