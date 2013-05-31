class CreateCoordinators < ActiveRecord::Migration
  def change
    create_table :coordinators do |t|
      t.string :name
      t.string :about
      t.string :location
      t.string :contact

      t.timestamps
    end
  end
end
