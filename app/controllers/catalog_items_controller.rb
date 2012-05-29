class CatalogItemsController < ApplicationController
  
  def index
    @catalog_items = current_member.account.catalog_items
  end
  
  def new
    @catalog_item = CatalogItem.new
  end
  
  def create
    @catalog_item = current_member.account.catalog_items.build(params[:catalog_item])
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
