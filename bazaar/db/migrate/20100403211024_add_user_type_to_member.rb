class AddUserTypeToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :userType, :integer
  end

  def self.down
    remove_column :members, :userType
  end
end
