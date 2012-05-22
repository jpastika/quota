class CatalogItemsController < ApplicationController
  
  def index
    @catalog_items = current_member.account.catalog_items
  end
end
