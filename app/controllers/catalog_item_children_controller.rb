class CatalogItemChildrenController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    # respond_to do |format|
    #       format.html {
    #         @contact = Contact.find_by_pub_key(params[:id])
    #         @contact_phones = @contact.phones
    #       }
    #       format.json { 
    #         @contact = Contact.find_by_pub_key(params[:contact_id])
    #         @contact_phones = @contact.phones
    #         render :json => @contact_phones
    #       }
    #     end
  end
  
  def show
    
  end
  
  def new
    
  end
  
  def create
    @parent_item = CatalogItem.find_by_pub_key(params[:parent_key])
    @child_item = CatalogItem.find_by_pub_key(params[:child_key])
    
    respond_to do |format|
      format.html {
        @catalog_item_child = CatalogItemChild.new(parent_key: params[:parent_key], child_key: params[:child_key])
        if @catalog_item_child.save
          flash[:success] = "#{@child_item.name} saved."
          redirect_to catalog_items_path
        else
          render 'new'
        end
      }
      format.json {
        if @parent_item and @child_item
          @catalog_item_child = CatalogItemChild.new(parent_key: params[:parent_key], child_key: params[:child_key])
          if @catalog_item_child.save
            render :json => @catalog_item_child.to_json(:include => :child_item)
          else
            render :json => "false", :status => :unprocessable_entity
          end
        else
          render :json => "false", :status => :unprocessable_entity
        end
      }
    end
  end
  
  def edit
    
  end
  
  def update
    # respond_to do |format|
    #       format.html {
    #         @contact_phone = ContactPhone.find_by_pub_key(params[:id])
    #         if @contact_phone.update_attributes(params[:contact_phone])
    #           flash[:success] = "Contact Phone updated"
    #           redirect_to contacts_path
    #         else
    #           render 'edit'
    #         end
    #       }
    #       format.json {
    #         @contact_phone = ContactPhone.find_by_pub_key(params[:id])      
    #         if @contact_phone.update_attributes(name: params[:contact_phone][:name], val: params[:contact_phone][:val])
    #           render :json => @contact_phone
    #         else
    #           render :json => "false"
    #         end
    #       }
    #     end
  end
  
  def destroy
    respond_to do |format|
      # format.html {
      #         @opportunity_contact = OpportunityContact.find_by_pub_key(params[:id])
      #         if @opportunity_contact.destroy
      #           flash[:success] = "Contact removed"
      #           redirect_to opportunities_path
      #         else
      #           render 'edit'
      #         end
      #       }
      format.json {
        @catalog_item_child = CatalogItemChild.find_by_pub_key(params[:id])      
        if @catalog_item_child.destroy
          render :json => @catalog_item_child
        else
          render :json => "false"
        end
      }
    end
  end
end