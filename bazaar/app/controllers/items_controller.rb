class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
#   @items = Item.find(:all)

    #trying to implement search here itself
    #selected_type = params([item_type][id])
    @items = Item.search(params[:search], params[:by])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  
    def shortindex
#    @items = Item.find(:all)

    #trying to implement search here itself
    #selected_type = params([item_type][id])
    @items = Item.find(:all, :limit=>5, :order=>"dateAdded DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end
  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    if @item.saleStatus == "3"
         flash[:notice] = 'This item has already been sold, and can no longer be edited'
          redirect_to :controller => 'user' , :action => 'login'
    else
    admin_or_user(@item)
    end
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    @item.seller_id = session[:member_id]

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])


    respond_to do |format|
      if @item.update_attributes(params[:item])
            if @item.saleStatus == "3"
      trans = Array.new
      trans = Transaction.find_all_by_item_id(@item.id)
      for temp in trans
      temp.transaction_status = "Completed"
      temp.save!
      end

    end
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
  @item = Item.find(params[:id])
if admin_or_user(@member)
  else

    @transaction = Transaction.find_by_item_id(@item.id)
    if @transaction
      @transaction.destroy
    else
      
    end
    
    @item.destroy
    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  end

  def buy
    if authorize
    else

    @item = Item.find(params[:id])
    if ((@item.saleStatus == '1') && (@item.seller_id != session[:member_id]))
     
      @item.saleStatus = 2
      @item.save!
      @transaction = Transaction.new(:transaction_status => "not complete", :buyer_id =>session[:member_id], :item_id =>@item.id, :date => Time.now)
      @transaction.save!

# test for sending an email to the seller
       email1 = OrderMailer.create_notifyseller(Member.find_by_id(@item.seller_id), @transaction)
       render(:text => "<pre>" + email1.encoded + "</pre>" )

#      redirect_to(@item)

    else
      redirect_to(@item)
      if @item.seller_id == session[:member_id]
        flash[:notice] = 'This item was posted by you!'
      elsif @item.saleStatus != 1
        flash[:notice] = 'Sorry, but another member has already expressed consent to purchase this item'
      end
    end
  end
  end

  def mine
    #temp = session[:member_id]
    #if temp == 5
    @items = Item.find_all_by_seller_id(session[:member_id])
      #@items = Item.find(:all, :conditions => ":seller_id == 5")
    #end
  end

  def search
    @items = Item.search(params[:search], :by)
  end
  
end

