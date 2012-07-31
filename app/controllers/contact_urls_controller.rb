class ContactUrlsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    respond_to do |format|
      format.html {
        @contact = Contact.find_by_pub_key(params[:id])
        @contact_urls = @contact.urls
      }
      format.json { 
        @contact = Contact.find_by_pub_key(params[:contact_id])
        @contact_urls = @contact.urls
        render :json => @contact_urls
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
        @contact_url = current_user.account.contact_urls.build(contact_key: params[:contact_url][:contact_key], name: params[:contact_url][:name], val: params[:contact_url][:val])
        if @contact_url.save
          flash[:success] = "#{@contact_url.name} saved."
          redirect_to contacts_path
        else
          render 'new'
        end
      }
      format.json {
        @contact = Contact.find_by_pub_key(params[:contact_id])
        @contact_url = current_user.account.contact_urls.build(contact_key: params[:contact_url][:contact_key], name: params[:contact_url][:name], val: params[:contact_url][:val])
        if @contact_url.save
          render :json => @contact_url
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
        @contact_url = ContactUrl.find_by_pub_key(params[:id])
        if @contact_url.update_attributes(params[:contact_url])
          flash[:success] = "Contact Url updated"
          redirect_to contacts_path
        else
          render 'edit'
        end
      }
      format.json {
        @contact_url = ContactUrl.find_by_pub_key(params[:id])      
        if @contact_url.update_attributes(name: params[:contact_url][:name], val: params[:contact_url][:val])
          render :json => @contact_url
        else
          render :json => "false"
        end
      }
    end
  end
  
  def destroy
    respond_to do |format|
      format.html {
        @contact_url = ContactUrl.find_by_pub_key(params[:id])
        if @contact_url.destroy
          flash[:success] = "Contact Url updated"
          redirect_to contacts_path
        else
          render 'edit'
        end
      }
      format.json {
        @contact_url = ContactUrl.find_by_pub_key(params[:id])      
        if @contact_url.destroy
          render :json => @contact_url
        else
          render :json => "false"
        end
      }
    end
  end
end