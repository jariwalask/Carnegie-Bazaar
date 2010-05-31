class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :fname
      t.string :lname
      t.string :username
      t.string :email
      t.string :phone
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
