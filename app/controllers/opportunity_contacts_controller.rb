class OpportunityContactsController < ApplicationController
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
    respond_to do |format|
      format.html {
        @opportunity_contact = current_user.account.opportunity_contacts.build(contact_key: params[:contact_key], opportunity_key: params[:opportunity_key])
        if @opportunity_contact.save
          flash[:success] = "#{@opportunity_contact.name} saved."
          redirect_to contacts_path
        else
          render 'new'
        end
      }
      format.json {
        @opportunity_contact = current_user.account.opportunity_contacts.build(contact_key: params[:contact_key], opportunity_key: params[:opportunity_key])
        if @opportunity_contact.save
          render :json => @opportunity_contact.to_json(:include => :contact)
        else
          render :json => "false"
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
    # respond_to do |format|
    #       format.html {
    #         @contact_phone = ContactPhone.find_by_pub_key(params[:id])
    #         if @contact_phone.destroy
    #           flash[:success] = "Contact Phone updated"
    #           redirect_to contacts_path
    #         else
    #           render 'edit'
    #         end
    #       }
    #       format.json {
    #         @contact_phone = ContactPhone.find_by_pub_key(params[:id])      
    #         if @contact_phone.destroy
    #           render :json => @contact_phone
    #         else
    #           render :json => "false"
    #         end
    #       }
    #     end
  end
end