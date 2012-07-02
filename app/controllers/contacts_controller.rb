class ContactsController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  
  def index
    respond_to do |format|
      format.html {
        @contacts = current_member.account.contacts
      }
      format.json { 
        @contacts = current_member.account.contacts
        render :json => @contacts
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        @contact = Contact.find_by_pub_key(params[:id])
      }
      format.json {
        @contact = Contact.find_by_pub_key(params[:id]) 
        render :json => @contact.to_json(:include => :contact_type)
      }
    end
  end
  
  def new
    @contact_types = current_member.account.contact_types.all
    @contact = current_member.account.contacts.build()
  end
  
  def create
    @contact = current_member.account.contacts.build(params[:contact])
    
    if @contact.save
      flash[:success] = "#{@contact.name} is now a contact on your Quota account."
      redirect_to contacts_path
    else
      render 'new'
    end
  end
  
  def edit
    @contact_types = current_member.account.contact_types.all
    @contact = Contact.find_by_pub_key(params[:id])
  end
  
  def update
    @contact = Contact.find_by_pub_key(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:success] = "Contact updated"
      redirect_to contacts_path
    else
      render 'edit'
    end
  end
end