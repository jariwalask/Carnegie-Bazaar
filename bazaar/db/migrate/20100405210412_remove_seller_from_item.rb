class RemoveSellerFromItem < ActiveRecord::Migration
  def self.up
    remove_column :items, :seller
  end

  def self.down
    add_column :items, :seller, :string
  end
end
