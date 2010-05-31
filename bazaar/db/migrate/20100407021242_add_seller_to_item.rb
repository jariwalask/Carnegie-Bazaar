class AddSellerToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :seller, :string
  end

  def self.down
    remove_column :items, :seller
  end
end
