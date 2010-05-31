class SaleStatusesController < ApplicationController
    before_filter :isAdmin
  # GET /sale_statuses
  # GET /sale_statuses.xml
  def index
    @sale_statuses = SaleStatus.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sale_statuses }
    end
  end

  # GET /sale_statuses/1
  # GET /sale_statuses/1.xml
  def show
    @sale_status = SaleStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sale_status }
    end
  end

  # GET /sale_statuses/new
  # GET /sale_statuses/new.xml
  def new
    @sale_status = SaleStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale_status }
    end
  end

  # GET /sale_statuses/1/edit
  def edit
    @sale_status = SaleStatus.find(params[:id])
  end

  # POST /sale_statuses
  # POST /sale_statuses.xml
  def create
    @sale_status = SaleStatus.new(params[:sale_status])

    respond_to do |format|
      if @sale_status.save
        flash[:notice] = 'SaleStatus was successfully created.'
        format.html { redirect_to(@sale_status) }
        format.xml  { render :xml => @sale_status, :status => :created, :location => @sale_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sale_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sale_statuses/1
  # PUT /sale_statuses/1.xml
  def update
    @sale_status = SaleStatus.find(params[:id])

    respond_to do |format|
      if @sale_status.update_attributes(params[:sale_status])
        flash[:notice] = 'SaleStatus was successfully updated.'
        format.html { redirect_to(@sale_status) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_statuses/1
  # DELETE /sale_statuses/1.xml
  def destroy
    @sale_status = SaleStatus.find(params[:id])
    @sale_status.destroy

    respond_to do |format|
      format.html { redirect_to(sale_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
