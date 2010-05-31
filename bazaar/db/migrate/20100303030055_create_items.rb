class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :seller_id
      t.integer :type_id
      t.string :itemTitle
      t.text :itemDescription
      t.float :cost
      t.date :dateAdded
      t.string :saleStatus

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
