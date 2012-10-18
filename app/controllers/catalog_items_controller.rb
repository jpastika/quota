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
    @account_key = @current_user.account_key
    # @companies = Contact.companies(@current_user.account)
    #     @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
    @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL AND account_key = '#{ @account_key }'")
    
    # gon.companies = @companies
    #     gon.milestones = @milestones
    gon.manufacturers = @manufacturers
    
    @catalog_item = CatalogItem.new
    
    gon.catalog_item = @catalog_item
  end
  
  # def new
  #     @catalog_item = CatalogItem.new
  #   end
  
  def create
    # @catalog_item = current_user.account.catalog_items.build(params[:catalog_item])
    #     if @catalog_item.save
    #       flash[:success] = "Item created!"
    #       redirect_to catalog_items_path
    #     else
    #       render 'new'
    #     end
  
    # # handle is_sold checkbox
    #     if params[:opportunity][:is_sold] != "true"
    #       params[:opportunity][:is_sold] = false
    #     end
    #     
    #     # handle is_cancelled checkbox
    #     if params[:opportunity][:is_cancelled] != "true"
    #       params[:opportunity][:is_cancelled] = false
    #     end
    
    @catalog_item = current_user.account.catalog_items.build(params[:catalog_item])
    @catalog_item.account = current_user.account
    # @catalog_item.owner = current_user
    
    # if (@opportunity.company_key.nil? || @opportunity.company_key == "") && (!params[:customer][:company_name].nil? && params[:customer][:company_name] != "")
    #       @company = current_user.account.contacts.companies(current_user.account).build(name: params[:customer][:company_name])
    #       if @company.save
    #         @opportunity.company_key = @company.pub_key
    #       end
    #     end
    
    if @catalog_item.save
      flash[:success] = "Catalog item has been created"
      redirect_to catalog_item_path(@catalog_item.pub_key)
    else
      @account_key = @current_user.account_key
      # @companies = Contact.companies(@current_user.account)
      #       @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
      #       @users = User.where(:account_key => @current_user.account.pub_key)
      # 
      #       gon.companies = @companies
      #       gon.milestones = @milestones
      #       gon.users = @users
      
      gon.catalog_item = @catalog_item
      @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL AND account_key = '#{ @account_key }'")

      gon.manufacturers = @manufacturers
      
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
  
  def manufacturers
    @account_key = @current_user.account_key
    respond_to do |format|
      format.html {
        @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL AND account_key = '#{ @account_key }'")
      }
      format.json { 
        @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL AND account_key = '#{ @account_key }'")
        
        render :json => @manufacturers.to_json(:include => [])
      }
    end
  end
end
