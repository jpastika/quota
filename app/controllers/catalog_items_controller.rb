class CatalogItemsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def index
    respond_to do |format|
      format.html {
        @account_key = @current_user.account.pub_key
        @catalog_items = CatalogItem.find(:all, :conditions => {:account_key => @account_key})
        
        gon.catalog_items = @catalog_items.to_json(:include => [])
        gon.current_member = @current_user
      }
      format.json { 
        @account_key = @current_user.account.pub_key
        @catalog_items = CatalogItem.find(:all, :conditions => {:account_key => @account_key})
        
        render :json => @catalog_items.to_json(:include => [])
      }
    end
  end
  
  def new
    @catalog_item = CatalogItem.new
  end
  
  def create
    @catalog_item = current_user.account.catalog_items.build(params[:catalog_item])
    if @catalog_item.save
      flash[:success] = "Item created!"
      redirect_to catalog_items_path
    else
      render 'new'
    end
  end
  
  def edit
    @catalog_item = CatalogItem.find_by_pub_key(params[:id])
  end
  
  def update
    @catalog_item = CatalogItem.find_by_pub_key(params[:id])
    if @catalog_item.update_attributes(params[:catalog_item])
      flash[:success] = "Catalog Item updated"
      redirect_to catalog_items_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @catalog_item = CatalogItem.find_by_pub_key(params[:id])
    @catalog_item.destroy
    redirect_back_or catalog_items_path
  end
end
