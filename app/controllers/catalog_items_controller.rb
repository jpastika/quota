class CatalogItemsController < ApplicationController
  
  def index
    @catalog_items = current_member.account.catalog_items
  end
  
  def new
    @catalog_item = CatalogItem.new
  end
  
  def edit
    @catalog_item = CatalogItem.find(params[:id])
  end
  
  def update
    @catalog_item = CatalogItem.find(params[:id])
    if @catalog_item.update_attributes(params[:catalog_item])
      flash[:success] = "Catalog Item updated"
      redirect_to catalog_items_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @catalog_item = CatalogItem.find(params[:id])
    @catalog_item.destroy
    redirect_back_or catalog_items_path
  end
end
