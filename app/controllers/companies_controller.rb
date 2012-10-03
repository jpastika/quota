class CompaniesController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    respond_to do |format|
      format.html {
        @account_key = @current_user.account_key
        @companies = Contact.companies(@current_user.account)
        @contact_types = ContactType.where(:account_key => @account_key)
        
        # @contacts = current_member.account.contacts
        gon.contact_types = @contact_types
        gon.companies = @companies
      }
      format.json { 
        @companies = Contact.companies(@current_user.account)
        # @contacts = current_member.account.contacts
        render :json => @companies.to_json(:include => :contact_type)
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        @account_key = @current_user.account_key
        @companies = Contact.companies(@current_user.account)
        @contact_types = ContactType.where(:account_key => @account_key)
        
        @company = Contact.find_by_pub_key(params[:id])
        @contact_type = "Company"
        @company_contacts = Contact.find_by_company_key(@contact.pub_key)
        
        gon.contact_types = @contact_types
        gon.companies = @companies
      }
      format.json {
        @company = Contact.find_by_pub_key(params[:id])
        gon.contact_types = current_user.account.contact_types.all
        gon.company = @company
        gon.companies = Contact.companies(@current_user.account)
        gon.contact_phones = @company.phones
        gon.contact_emails = @company.emails
        gon.contact_urls = @company.urls
        gon.contact_addresses = @company.addresses
        
         
        render :json => @company.to_json(:include => :contact_type)
      }
    end
  end
  
  def new
    # @account_key = @current_user.account_key
    #     @contacts = Contact.where(:account_key => @account_key)
    #     @contact_types = ContactType.where(:account_key => @account_key)
    #     @companies = Contact.companies(@current_user.account)
    #     
    #     gon.contact_types = @contact_types
    #     gon.contact = current_user.account.contacts.new()
    #     gon.companies = @companies
    #     
    #     respond_to do |format|
    #       format.html {
    #         @contact = current_user.account.contacts.build(contact_type_key: @contact_types.find_by_name("Person").pub_key)
    #       }
    #       format.json {
    #         @contact = current_user.account.contacts.build(contact_type_key: @contact_types.find_by_name("Person").pub_key)
    #         render :json => @contact.to_json()
    #       }
    #     end
  end
  
  def create
    # respond_to do |format|
    #       format.html {
    #         @contact = current_user.account.contacts.build(params[:contact])
    #         if @contact.save
    #           flash[:success] = "#{@contact.name} is now a contact on your Quota account."
    #           redirect_to contacts_path
    #         else
    #           render 'new'
    #         end
    #       }
    #       format.json {
    #         @contact = current_user.account.contacts.build(params[:contact])
    #         # @contact.save
    #         if @contact.save
    #           render :json => @contact.to_json(:include => :contact_type)
    #         else
    #           render :json => "false"
    #         end
    #       }
    #     end
  end
  
  def edit
    # @account_key = @current_user.account_key
    #     @contacts = Contact.where(:account_key => @account_key)
    #     @contact_types = ContactType.where(:account_key => @account_key)
    #     @companies = Contact.companies(@current_user.account)
    #     
    #     gon.contact_types = @contact_types
    #     gon.contact = current_user.account.contacts.new()
    #     gon.companies = @companies
    #     
    #     
    #     @contact = Contact.find_by_pub_key(params[:id])
    #     gon.contact = @contact
    #     gon.contact_phones = @contact.phones
    #     gon.contact_emails = @contact.emails
    #     gon.contact_urls = @contact.urls
    #     gon.contact_addresses = @contact.addresses
  end
  
  def update
    # respond_to do |format|
    #       format.html {
    #         @contact = Contact.find_by_pub_key(params[:id])
    #         if @contact.update_attributes(params[:contact])
    #           flash[:success] = "Contact updated"
    #           redirect_to contacts_path
    #         else
    #           render 'edit'
    #         end
    #       }
    #       format.json {
    #         @contact = Contact.find_by_pub_key(params[:id])      
    #         if @contact.update_attributes(name: params[:contact][:name], title: params[:contact][:title], company_key: params[:contact][:company_key], contact_type_key: params[:contact][:contact_type_key])
    #           render :json => @contact.to_json(:include => :contact_type)
    #         else
    #           render :json => "false"
    #         end
    #       }
    #     end
  end
  
  
  def contacts
    respond_to do |format|
      format.html {
        @contacts = Contact.where(:company_key => params[:id])
      }
      format.json { 
        @contacts = Contact.where(:company_key => params[:id])
        render :json => @contacts.to_json(:include => :contact_type)
      }
    end
  end

end