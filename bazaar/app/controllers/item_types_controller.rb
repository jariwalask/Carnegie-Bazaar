class ItemTypesController < ApplicationController
    before_filter :isAdmin
  # GET /item_types
  # GET /item_types.xml
  def index
    @item_types = ItemType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @item_types }
    end
  end

  # GET /item_types/1
  # GET /item_types/1.xml
  def show
    @item_type = ItemType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item_type }
    end
  end

  # GET /item_types/new
  # GET /item_types/new.xml
  def new
    @item_type = ItemType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item_type }
    end
  end

  # GET /item_types/1/edit
  def edit
    @item_type = ItemType.find(params[:id])
  end

  # POST /item_types
  # POST /item_types.xml
  def create
    @item_type = ItemType.new(params[:item_type])

    respond_to do |format|
      if @item_type.save
        flash[:notice] = 'ItemType was successfully created.'
        format.html { redirect_to(@item_type) }
        format.xml  { render :xml => @item_type, :status => :created, :location => @item_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /item_types/1
  # PUT /item_types/1.xml
  def update
    @item_type = ItemType.find(params[:id])

    respond_to do |format|
      if @item_type.update_attributes(params[:item_type])
        flash[:notice] = 'ItemType was successfully updated.'
        format.html { redirect_to(@item_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /item_types/1
  # DELETE /item_types/1.xml
  def destroy
    @item_type = ItemType.find(params[:id])
    tempList = Array.new
    test = Array.new
    tempList = Item.getTransactionType(@item_type.id)
    if tempList.length == 0
      flash[:notice] = 'YES'
       @item_type.destroy
    else
      flash[:notice] = 'This can not be deleted because one or more 	Items ar using this type'
    end

    respond_to do |format|
      format.html { redirect_to(item_types_url) }
      format.xml  { head :ok }
    end
  end
end
