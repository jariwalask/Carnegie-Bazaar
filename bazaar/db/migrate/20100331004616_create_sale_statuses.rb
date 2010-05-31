class CreateSaleStatuses < ActiveRecord::Migration
  def self.up
    create_table :sale_statuses do |t|
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :sale_statuses
  end
end
