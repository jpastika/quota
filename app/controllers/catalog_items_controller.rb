class CatalogItemsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def index
    respond_to do |format|
      format.html {
        @account_key = @current_user.account.pub_key
        # @catalog_items = CatalogItem.find(:all, :conditions => {:account_key => @account_key})
        # @catalog_items = CatalogItem.all
        #         
        #         gon.catalog_items = @catalog_items.to_json(:include => [:child_items])
        gon.current_member = @current_user
      }
      format.json { 
        # @catalog_items = CatalogItem.find(:all, :conditions => {:account_key => @account_key})
        @catalog_items = CatalogItem.all
        
        render :json => @catalog_items.to_json(:include => [:child_items])
      }
    end
  end
  
  def show
    # @opportunity = Opportunity.find_by_pub_key(params[:id])
    respond_to do |format|
      format.html {
        @catalog_item = CatalogItem.find_by_pub_key(params[:id])
        
        gon.catalog_item = @catalog_item.to_json(:include => [])
        # gon.opportunity_contacts = @opportunity.opportunity_contacts.to_json(:include => {:contact => {:include => [:phones, :emails, :company]}})
        #         gon.opportunity_documents = @opportunity.documents
        #         gon.companies = Contact.companies(@current_user.account)
        
        # gon.child_items = @catalog_item.child_items.to_json(:include => [])
        gon.catalog_item_children = @catalog_item.catalog_item_children.to_json(:include => [:child_item])
        
        @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL")

        gon.manufacturers = @manufacturers
      }
      format.json {
        @catalog_item = CatalogItem.find_by_pub_key(params[:id])
        
        render :json => @catalog_item.to_json(:include => [:child_items])
      }
    end
  end
  
  def new
    # @account_key = @current_user.account_key
    # @companies = Contact.companies(@current_user.account)
    #     @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
    @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL")
    
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
    respond_to do |format|
      format.html {
        # handle is_taxable checkbox
        if params[:catalog_item][:is_taxable] != "true" && params[:catalog_item][:is_taxable] != true
          params[:catalog_item][:is_taxable] = false
        end

        # handle is_package checkbox
        if params[:catalog_item][:is_package] != "true" && params[:catalog_item][:is_package] != true
          params[:catalog_item][:is_package] = false
        end

        @catalog_item = CatalogItem.create(params[:catalog_item])
        @catalog_item.list_price = params[:catalog_item][:list_price].to_s.delete ","
        
        if @catalog_item.save
          flash[:success] = "Catalog item has been created"
          redirect_to catalog_item_path(@catalog_item.pub_key)
        else
          gon.catalog_item = @catalog_item
          @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL")

          gon.manufacturers = @manufacturers

          render 'new'
        end
      }
      format.json {
        # handle is_taxable checkbox
        if params[:catalog_item][:is_taxable] != "true" && params[:catalog_item][:is_taxable] != true
          params[:catalog_item][:is_taxable] = false
        end

        # handle is_package checkbox
        if params[:catalog_item][:is_package] != "true" && params[:catalog_item][:is_package] != true
          params[:catalog_item][:is_package] = false
        end

        @catalog_item = CatalogItem.create(params[:catalog_item])
        @catalog_item.list_price = params[:catalog_item][:list_price].to_s.delete ","
        
        if @catalog_item.save
          render :json => @catalog_item.to_json(:include => [])
        else
          render :json => "false"
        end
      }
    end
  end
  
  def edit
    @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL")
    
    # gon.companies = @companies
    #     gon.milestones = @milestones
    gon.manufacturers = @manufacturers
    
    @catalog_item = CatalogItem.find_by_pub_key(params[:id])
    gon.catalog_item = @catalog_item
    
  end
  
  def update
    @catalog_item = CatalogItem.find_by_pub_key(params[:id])
    
    respond_to do |format|
      format.html {
        # handle is_taxable checkbox
        if params[:catalog_item][:is_taxable] != "true"
          params[:catalog_item][:is_taxable] = false
        end

        # handle is_package checkbox
        if params[:catalog_item][:is_package] != "true"
          params[:catalog_item][:is_package] = false
        end

        if @catalog_item.update_attributes(params[:catalog_item])
          @catalog_item.list_price = params[:catalog_item][:list_price].to_s.delete ","
          @catalog_item.save
          flash[:success] = "Catalog Item updated"
          redirect_to catalog_item_path(@catalog_item.pub_key)
        else
          render 'edit'
        end
      }
      
      format.json {
        if @catalog_item
          if params[:is_taxable] != "true"
            params[:is_taxable] = false
          end

          # handle is_package checkbox
          if params[:is_package] != "true"
            params[:is_package] = false
          end
          
          @catalog_item.is_taxable = params[:is_taxable]
          @catalog_item.is_package = params[:is_package]
          @catalog_item.name = params[:name]
          @catalog_item.manufacturer = params[:manufacturer]
          @catalog_item.list_price = params[:list_price].to_s.delete ","
          @catalog_item.recurring_unit = params[:recurring_unit]
          @catalog_item.part_number = params[:part_number]
          @catalog_item.parent_key = params[:parent_key]
          
          if @catalog_item.save
            render :json => @catalog_item.to_json(:include => [])
          else
            render :json => "false", :status => :unprocessable_entity
          end
        else
          render :json => "false", :status => :unprocessable_entity
        end
      }
    end
  end
  
  def destroy
    respond_to do |format|
      format.html {
        @catalog_item = CatalogItem.find_by_pub_key(params[:id])
        @catalog_item.destroy
        redirect_back_or catalog_items_path
      }
      format.json {
        @catalog_item = CatalogItem.find_by_pub_key(params[:id])      
        if @catalog_item.destroy
          render :json => @catalog_item
        else
          render :json => "false"
        end
      }
    end
  end
  
  def manufacturers
    @account_key = @current_user.account_key
    respond_to do |format|
      format.html {
        @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL")
      }
      format.json { 
        @manufacturers = CatalogItem.find(:all, :select => "DISTINCT manufacturer", :conditions => "manufacturer IS NOT NULL")
        
        render :json => @manufacturers.to_json(:include => [])
      }
    end
  end
  
  def filter_by_name_or_part_number
    respond_to do |format|
      format.html {
        @catalog_items = CatalogItem.find_by_name_or_part_number(params[:filter])
      }
      format.json { 
        @catalog_items = CatalogItem.find_by_name_or_part_number(params[:filter])
        # @catalog_items = CatalogItem.all
        
        render :json => @catalog_items.to_json()
        # render :json => CatalogItem.first
      }
    end
  end
end
