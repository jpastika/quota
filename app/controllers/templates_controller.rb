class TemplatesController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    # @templates = current_user.account.templates
    respond_to do |format|
      format.html {
        @account_key = @current_user.account.pub_key
        # @catalog_items = CatalogItem.find(:all, :conditions => {:account_key => @account_key})
        # @templates = Template.all
        #         
        #         gon.templates = @templates.to_json(:include => [:document_type])
        
        @templates = Template.all

        gon.templates = @templates.to_json(:include => [:document_type, :template_items])
        gon.current_member = @current_user
      }
      format.json { 
        # @account_key = @current_user.account.pub_key
        @templates = Template.all
        
        render :json => @templates.to_json(:include => [:document_type])
      }
    end
  end
  
  def show
    # @template = Template.find_by_pub_key(params[:id])
    respond_to do |format|
      format.html {
        @template = Template.find_by_pub_key(params[:id])
        
        gon.template = @template.to_json(:include => [:document_type])
        gon.template_items = @template.template_items.to_json(:include => [:catalog_item])
        
        # @catalog_items = CatalogItem.all
        #         gon.catalog_items = @catalog_items.to_json(:include => [])
        # gon.opportunity_contacts = @opportunity.opportunity_contacts.to_json(:include => {:contact => {:include => [:phones, :emails, :company]}})
        #         gon.opportunity_documents = @opportunity.documents
        #         gon.companies = Contact.companies(@current_user.account)
        
      }
      format.json {
        @template = Template.find_by_pub_key(params[:id])
        
        render :json => @template.to_json(:include => [:document_type, {:template_items => {:include => [:catalog_item]}}])
      }
    end
  end
  
  
  def new
    @template = Template.new
    
    gon.template = @template
  end
  
  def create
    respond_to do |format|
      format.html {
       @template = Template.create(params[:template])
        if @template.save
          flash[:success] = "Template has been created"
          redirect_to template_path(@template.pub_key)
        else
          gon.template = @template
          render 'new'
        end
      }
      format.json {
        @template = Template.create(params[:template])
        if @template.save
          render :json => @template.to_json(:include => [])
        else
          render :json => "false"
        end
      }
    end
  end
  
  def edit
    @template = Template.find_by_pub_key(params[:id])
    gon.template = @template
    
  end
  
  def update
    @template = Template.find_by_pub_key(params[:id])
    
    respond_to do |format|
      format.html {
        if @template.update_attributes(params[:template])
          flash[:success] = "Template updated"
          redirect_to template_path(@template.pub_key)
        else
          render 'edit'
        end
      }
      
      format.json {
        if @template
          @template.name = params[:name]
          @template.description = params[:description]
          # @template.description = params[:description]
          #           @template.instructions = params[:instructions]
          #           
          @template.total_purchase = params[:total_purchase]
          @template.total_hourly = params[:total_hourly]
          @template.total_daily = params[:total_daily]
          @template.total_weekly = params[:total_weekly]
          @template.total_monthly = params[:total_monthly]
          @template.total_quarterly = params[:total_quarterly]
          @template.total_yearly = params[:total_yearly]
          
          if @template.save
            render :json => @template.to_json(:include => [])
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
        @template = Template.find_by_pub_key(params[:id])
        @template.destroy
        redirect_back_or templates_path
      }
      format.json {
        @template = Template.find_by_pub_key(params[:id])   
        if @template.destroy
          render :json => @template
        else
          render :json => "false"
        end
      }
    end
  end
  
  def filter_by_name_or_item
    respond_to do |format|
      format.html {
        @templates = Template.find_by_name_or_item(params[:filter])
      }
      format.json { 
        @templates = Template.find_by_name_or_item(params[:filter])
        
        render :json => @templates.to_json()
      }
    end
  end
end
