class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :item_id
      t.integer :buyer_id
      t.date :date
      t.string :transaction_status

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
