class AddDescriptionToSaleStatus < ActiveRecord::Migration
  def self.up
    add_column :sale_statuses, :description, :text
  end

  def self.down
    remove_column :sale_statuses, :description
  end
end
