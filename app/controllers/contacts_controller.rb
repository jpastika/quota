class ContactsController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  
  def index
    @contacts = current_member.account.contacts
  end
  
  def new
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