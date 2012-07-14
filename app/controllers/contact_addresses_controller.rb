class ContactAddressesController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  respond_to :html, :json
  
  def index
    respond_to do |format|
      @contact = Contact.find_by_pub_key(params[:id])
      @contact_addresses = @contact.addresses
      format.html {
        
      }
      format.json { 
        render :json => @contact_addresses
      }
    end
  end
  
  def show
    
  end
  
  def new
    
  end
  
  def create
    respond_to do |format|
      format.html {
        @contact = Contact.find_by_pub_key(params[:contact_id])
        @contact_address = current_member.account.contact_addresses.build(contact_key: params[:contact_address][:contact_key], name: params[:contact_address][:name], street1: params[:contact_address][:street1], city: params[:contact_address][:city], state: params[:contact_address][:state], zip: params[:contact_address][:zip], country: params[:contact_address][:country])
        if @contact_address.save
          flash[:success] = "#{@contact_address.name} saved."
          redirect_to contacts_path
        else
          render 'new'
        end
      }
      format.json {
        @contact = Contact.find_by_pub_key(params[:contact_id])
        @contact_address = current_member.account.contact_addresses.build(contact_key: params[:contact_address][:contact_key], name: params[:contact_address][:name], street1: params[:contact_address][:street1], city: params[:contact_address][:city], state: params[:contact_address][:state], zip: params[:contact_address][:zip], country: params[:contact_address][:country])
        if @contact_address.save
          render :json => @contact_address
        else
          render :json => "false"
        end
      }
    end
  end
  
  def edit
    
  end
  
  def update
    respond_to do |format|
      format.html {
        @contact_address = ContactAddress.find_by_pub_key(params[:id])
        if @contact_address.update_attributes(params[:contact_address])
          flash[:success] = "Contact Address updated"
          redirect_to contacts_path
        else
          render 'edit'
        end
      }
      format.json {
        @contact_address = ContactAddress.find_by_pub_key(params[:id])      
        if @contact_address.update_attributes(name: params[:contact_address][:name], street1: params[:contact_address][:street1], city: params[:contact_address][:city], state: params[:contact_address][:state], zip: params[:contact_address][:zip], country: params[:contact_address][:country])
          render :json => @contact_address
        else
          render :json => "false"
        end
      }
    end
  end
  
  def destroy
    respond_to do |format|
      format.html {
        @contact_address = ContactAddress.find_by_pub_key(params[:id])
        if @contact_address.destroy
          flash[:success] = "Contact Address updated"
          redirect_to contacts_path
        else
          render 'edit'
        end
      }
      format.json {
        @contact_address = ContactAddress.find_by_pub_key(params[:id])      
        if @contact_address.destroy
          render :json => @contact_address
        else
          render :json => "false"
        end
      }
    end
  end
end