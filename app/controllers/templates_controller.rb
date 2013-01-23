class TemplatesController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    # @templates = current_user.account.templates
    respond_to do |format|
      format.html {
        @account_key = @current_user.account.pub_key
        # @catalog_items = CatalogItem.find(:all, :conditions => {:account_key => @account_key})
        @templates = Template.all
        
        gon.templates = @templates.to_json(:include => [:document_type])
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
        
        render :json => @template.to_json(:include => [:document_type])
      }
    end
  end
  
  
  def destroy
    @template = Template.find_by_pub_key(params[:id])
    @template.destroy
    redirect_back_or templates_path
  end
end
