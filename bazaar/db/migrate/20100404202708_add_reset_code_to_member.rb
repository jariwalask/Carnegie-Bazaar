class AddResetCodeToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :ResetCode, :string
  end

  def self.down
    remove_column :members, :ResetCode
  end
end
