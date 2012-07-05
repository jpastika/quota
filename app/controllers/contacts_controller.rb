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
    respond_to do |format|
      format.html {
        @contact = current_member.account.contacts.build(contact_type_key: current_member.account.contact_types.find_by_name("Person").pub_key)
      }
      format.json {
        @contact = current_member.account.contacts.build(contact_type_key: current_member.account.contact_types.find_by_name("Person").pub_key)
        render :json => @contact.to_json()
      }
    end
  end
  
  def create
    respond_to do |format|
      format.html {
        @contact = current_member.account.contacts.build(params[:contact])
    
        if @contact.save
          flash[:success] = "#{@contact.name} is now a contact on your Quota account."
          redirect_to contacts_path
        else
          render 'new'
        end
      }
      format.json {
        @contact = current_member.account.contacts.build(params[:contact])
        if @contact.save
          render :json => @contact.to_json(:include => :contact_type)
        end
      }
    end
  end
  
  def edit
    @contact_types = current_member.account.contact_types.all
    @contact = Contact.find_by_pub_key(params[:id])
  end
  
  def update
    
    
    respond_to do |format|
      format.html {
        @contact = Contact.find_by_pub_key(params[:id])
        if @contact.update_attributes(params[:contact])
          flash[:success] = "Contact updated"
          redirect_to contacts_path
        else
          render 'edit'
        end
      }
      format.json {
        @contact = Contact.find_by_pub_key(params[:id])
        if @contact.update_attributes(name: params[:contact][:name], title: params[:contact][:title], company_key: params[:contact][:company_key], contact_type_key: params[:contact][:contact_type_key])
          render :json => @contact.to_json(:include => :contact_type)
        else
          
        end
      }
    end
  end
  
  
  def companies
    respond_to do |format|
      format.html {
        @companies = current_member.account.contacts.companies
      }
      format.json { 
        @companies = current_member.account.contacts.companies
        render :json => @companies
      }
    end
  end
end