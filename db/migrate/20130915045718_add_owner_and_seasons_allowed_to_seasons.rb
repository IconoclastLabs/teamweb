class AddOwnerAndSeasonsAllowedToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :self_organized, :boolean, default: true
    add_column :seasons, :seasons_allowed, :boolean, default: false
  end
end
