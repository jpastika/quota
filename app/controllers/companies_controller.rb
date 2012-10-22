class CompaniesController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    respond_to do |format|
      format.html {
        # @account_key = @current_user.account_key
        @companies = Contact.companies
        @contact_types = ContactType.all
        
        # @contacts = current_member.account.contacts
        gon.contact_types = @contact_types
        gon.companies = @companies
      }
      format.json { 
        @companies = Contact.companies
        # @contacts = current_member.account.contacts
        render :json => @companies.to_json(:include => :contact_type)
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        # @account_key = @current_user.account_key
        @companies = Contact.companies
        @contact_types = ContactType.all
        
        @company = Contact.find_by_pub_key(params[:id])
        @contact_type = "Company"
        @company_contacts = Contact.find_by_company_key(@contact.pub_key)
        
        gon.contact_types = @contact_types
        gon.companies = @companies
      }
      format.json {
        @company = Contact.find_by_pub_key(params[:id])
        gon.contact_types = ContactType.all
        gon.company = @company
        gon.companies = Contact.companies
        gon.contact_phones = @company.phones
        gon.contact_emails = @company.emails
        gon.contact_urls = @company.urls
        gon.contact_addresses = @company.addresses
        
         
        render :json => @company.to_json(:include => :contact_type)
      }
    end
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