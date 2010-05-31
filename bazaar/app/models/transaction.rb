class Transaction < ActiveRecord::Base
  belongs_to :Member
  has_one :Item
   named_scope :getMemberTransactions, lambda { |member| { :conditions => ['buyer_id = ?', member] }}
end
