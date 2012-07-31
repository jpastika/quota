class ContactEmailsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    respond_to do |format|
      format.html {
        @contact = Contact.find_by_pub_key(params[:id])
        @contact_emails = @contact.emails
      }
      format.json { 
        @contact = Contact.find_by_pub_key(params[:contact_id])
        @contact_emails = @contact.emails
        render :json => @contact_emails
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
        @contact_email = current_user.account.contact_emails.build(contact_key: params[:contact_email][:contact_key], name: params[:contact_email][:name], val: params[:contact_email][:val])
        if @contact_email.save
          flash[:success] = "#{@contact_email.name} saved."
          redirect_to contacts_path
        else
          render 'new'
        end
      }
      format.json {
        @contact = Contact.find_by_pub_key(params[:contact_id])
        @contact_email = current_user.account.contact_emails.build(contact_key: params[:contact_email][:contact_key], name: params[:contact_email][:name], val: params[:contact_email][:val])
        if @contact_email.save
          render :json => @contact_email
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
        @contact_email = ContactEmail.find_by_pub_key(params[:id])
        if @contact_email.update_attributes(params[:contact_email])
          flash[:success] = "Contact Email updated"
          redirect_to contacts_path
        else
          render 'edit'
        end
      }
      format.json {
        @contact_email = ContactEmail.find_by_pub_key(params[:id])      
        if @contact_email.update_attributes(name: params[:contact_email][:name], val: params[:contact_email][:val])
          render :json => @contact_email
        else
          render :json => "false"
        end
      }
    end
  end
  
  def destroy
    respond_to do |format|
      format.html {
        @contact_email = ContactEmail.find_by_pub_key(params[:id])
        if @contact_email.destroy
          flash[:success] = "Contact Email updated"
          redirect_to contacts_path
        else
          render 'edit'
        end
      }
      format.json {
        @contact_email = ContactEmail.find_by_pub_key(params[:id])      
        if @contact_email.destroy
          render :json => @contact_email
        else
          render :json => "false"
        end
      }
    end
  end
end