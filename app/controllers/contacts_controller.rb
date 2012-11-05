class ContactsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    respond_to do |format|
      format.html {
        # @account_key = @current_user.account_key
        # @contacts = Contact.where(:account_key => @account_key)
        @contacts = Contact.all
        @contact_types = ContactType.all
        
        # @contacts = current_member.account.contacts
        gon.contact_types = @contact_types
        gon.contacts = @contacts
      }
      format.json { 
        # @contacts = Contact.where(:account_key => @current_user.account_key)
        @contacts = Contact.all
        # @contacts = current_member.account.contacts
        render :json => @contacts.to_json(:include => :contact_type)
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        # @account_key = @current_user.account_key
        @contacts = Contact.all
        @contact_types = ContactType.all
        
        @contact = Contact.find_by_pub_key(params[:id])
        if @contact.contact_type.name == "Company"
          @contact_type = "Company"
          @company_contacts = Contact.find_by_company_key(@contact.pub_key)
        else
          @contact_type = "Person"
          @company = @contact.company
        end
        
        gon.contact_types = @contact_types
        gon.contacts = @contacts
      }
      format.json {
        @contact = Contact.find_by_pub_key(params[:id])
        gon.contact_types = ContactType.all
        gon.contact = @contact
        gon.companies = Contact.companies
        gon.contact_phones = @contact.phones
        gon.contact_emails = @contact.emails
        gon.contact_urls = @contact.urls
        gon.contact_addresses = @contact.addresses
        
         
        render :json => @contact.to_json(:include => :contact_type)
      }
    end
  end
  
  def new
    # @account_key = @current_user.account_key
    @contacts = Contact.all
    @contact_types = ContactType.all
    @companies = Contact.companies
    
    gon.contact_types = @contact_types
    gon.contact = Contact.new()
    gon.companies = @companies
    
    respond_to do |format|
      format.html {
        @contact = Contact.create(contact_type_key: ContactType.find_by_name("Person").pub_key)
      }
      format.json {
        @contact = Contact.create(contact_type_key: ContactType.find_by_name("Person").pub_key)
        render :json => @contact.to_json()
      }
    end
  end
  
  def create
    respond_to do |format|
      format.html {
        @contact = Contact.create(params[:contact])
        if @contact.save
          flash[:success] = "#{@contact.name} is now a contact on your Quota account."
          redirect_to contacts_path
        else
          render 'new'
        end
      }
      format.json {
        if (params[:company_key].nil? || params[:company_key] == "") && (!params[:company_name].nil? && params[:company_name] != "")
          @company = Contact.companies.build(name: params[:company_name])
          @company.save
          @company_key = @company.pub_key
        else
          @company_key = params[:company_key]
        end
        
        @contact = Contact.people.build(name: params[:name], company_key: @company_key)
        
        # @contact.save
        if @contact.save
          if (!params[:contact_phone].nil? && params[:contact_phone] != "")
            @contact_phone = ContactPhone.create(contact_key: @contact.pub_key, name: "phone", val: params[:contact_phone])
            @contact_phone.save
          end
          
          if (!params[:contact_email].nil? && params[:contact_email] != "")
            @contact_email = ContactEmail.create(contact_key: @contact.pub_key, name: "email", val: params[:contact_email])
            @contact_email.save
          end
          
          render :json => @contact.to_json(:include => :contact_type)
        else
          render :json => "false"
        end
      }
    end
  end
  
  def edit
    @account_key = @current_user.account_key
    @contacts = Contact.all
    @contact_types = ContactType.all
    @companies = Contact.companies
    
    gon.contact_types = @contact_types
    gon.contact = Contact.new()
    gon.companies = @companies
    
    
    @contact = Contact.find_by_pub_key(params[:id])
    gon.contact = @contact
    gon.contact_phones = @contact.phones
    gon.contact_emails = @contact.emails
    gon.contact_urls = @contact.urls
    gon.contact_addresses = @contact.addresses
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
          render :json => "false"
        end
      }
    end
  end
  
  
  def companies
    respond_to do |format|
      format.html {
        @companies = Contact.companies
      }
      format.json { 
        @companies = Contact.companies
        render :json => @companies
      }
    end
  end

end