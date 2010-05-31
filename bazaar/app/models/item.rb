class Item < ActiveRecord::Base
  has_one :Transaction
  belongs_to :Member
  belongs_to :ItemType
  validates_presence_of :itemTitle, :itemDescription
  validates_numericality_of :cost, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_inclusion_of :type_id, :in => ItemType.all.map {|c| c.id}
  after_create :set_values
  cattr_reader :per_page
  @@per_page = 5
  named_scope :getItemSeller, lambda { |member| { :conditions => ['seller_id = ?', member] }}
  named_scope :getTransactionType, lambda {|type| {:conditions => ['type_id = ?', type]}}
  
  
  def set_values
    self.seller_id = @temp
    self.saleStatus = 1
    self.dateAdded = Time.now
    self.save!
  end

  def seller
    Member.find(seller_id).username
  end

  def type
    ItemType.find(type_id).itemType
  end

  def status
    SaleStatus.find(saleStatus).status
  end

#  def self.search(search, by)
#    if search
#      if !by || by == "Item"
#        find(:all, :conditions => ['itemTitle LIKE ?', "%#{search}%"])
#      elsif by == "Username"
#        find(:all, :conditions => ['seller_id LIKE ?', "%#{search}%"])
#      elsif by == "Type"
#        find(:all, :conditions => ['type_id LIKE ?', "%#{search}%"])
#      end
#    else
#      find(:all)
#    end
#  end

  def self.search(search, by)

    if search == ""
      find(:all, :order=>"dateAdded DESC")
    elsif by == "Item"
      find(:all, :conditions => ['itemTitle LIKE ?', "%#{search}%"])
    elsif by == "Username"
      find(:all, :conditions => ['seller LIKE ?', "%#{search}%"])
    elsif by == "Type"
#      @temp = ItemType.find_by_itemType(type)
#      @temp2 = self.find_all_by_type_id(@temp.id)
#      @temp2.find(:all, :conditions => ['itemTitle LIKE ?', "%#{search}%"])
        find(:all, :conditions => ['itemTitle LIKE ?', "%#{search}%"]) #using this till solution is found :@
    else
        find(:all, :order=>"dateAdded DESC")
    end

  end
 

#  def self.search(search, by, item)
#
#    if search == ""
#      find(:all)
#    elsif by == "Item"
#      find(:all, :conditions => ['itemTitle LIKE ?', "%#{search}%"])
#    elsif by == "Username"
#      find(:all, :conditions => ['seller LIKE ?', "%#{search}%"])
#    elsif by == "Type"
#      @temp = ItemType.find(:all, :conditions => ['itemType LIKE ?', "%#{by}%"])
#      find(:all, :conditions => ['type_id LIKE ?', "%#{search}%"])
#    else
#        find(:all)
#    end
#
#  end

end

