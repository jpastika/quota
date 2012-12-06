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
        gon.contacts = @contacts.to_json(:include => [:company, :phones, :emails])
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
    @contact_types = ContactType.all
    @companies = Contact.companies
    @contact = Contact.new
    
    gon.contact_types = @contact_types
    gon.contact = @contact
    gon.companies = @companies
    gon.contact_phones = @contact.phones.to_json(:include => [])
    gon.contact_emails = @contact.emails.to_json(:include => [])
    gon.contact_addresses = @contact.addresses.to_json(:include => [])
    gon.contact_urls = @contact.urls.to_json(:include => [])
    
    respond_to do |format|
      format.html {
        @contact.contact_type_key = ContactType.find_by_name("Person").pub_key
      }
      format.json {
        @contact.contact_type_key = ContactType.find_by_name("Person").pub_key
        render :json => @contact.to_json()
      }
    end
  end
  
  def create
    respond_to do |format|
      format.html {
        if (params[:contact][:company_key].nil? || params[:contact][:company_key] == "") && (!params[:contact][:company_name].nil? && params[:contact][:company_name] != "")
          @company = Contact.companies.create(name: params[:contact][:company_name])
          @company.save
          @company_key = @company.pub_key
        else
          @company_key = params[:contact][:company_key]
        end
        
        @contact = Contact.create(name: params[:contact][:name], company_key: @company_key, contact_type_key: params[:contact][:contact_type_key], title: params[:contact][:title])
        
        if @contact.save
          if params[:phones]
            params[:phones].each do |phone|
              @contact.phones.create!(name: phone[:name], val: phone[:val])
              # @contact.phones.create!(name: "test", val: "123")
            end
          end
          
          if params[:emails]
            params[:emails].each do |email|
              @contact.emails.create!(name: email[:name], val: email[:val])
              # @contact.phones.create!(name: "test", val: "123")
            end
          end
          
          if params[:urls]
            params[:urls].each do |url|
              @contact.urls.create!(name: url[:name], val: url[:val])
              # @contact.phones.create!(name: "test", val: "123")
            end
          end
          
          if params[:addresses]
            params[:addresses].each do |address|
              @contact.addresses.create!(name: address[:name], street1: address[:street1], city: address[:city], state: address[:state], zip: address[:zip], country: address[:country])
              # @contact.phones.create!(name: "test", val: "123")
            end
          end
          
          
          flash[:success] = "#{@contact.name} is now a contact on your Quota account."
          # @contacts = Contact.all
          #           @contact_types = ContactType.all
          # 
          #           # @contacts = current_member.account.contacts
          #           gon.contact_types = @contact_types
          #           gon.contacts = @contacts.to_json(:include => [:company, :phones, :emails])
          redirect_to contact_path(@contact.pub_key)
        else
          render 'new'
        end
      }
      format.json {
        if (params[:contact][:company_key].nil? || params[:contact][:company_key] == "") && (!params[:contact][:company_name].nil? && params[:contact][:company_name] != "")
          @company = Contact.companies.create(name: params[:contact][:company_name])
          @company.save
          @company_key = @company.pub_key
        else
          @company_key = params[:contact][:company_key]
        end
        
        @contact = Contact.people.create(name: params[:name], company_key: @company_key)
        
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
          render :json => @contact.to_json()
        end
      }
    end
  end
  
  def edit
    @account_key = @current_user.account_key
    @contact_types = ContactType.all
    @companies = Contact.companies
    @contact = Contact.find_by_pub_key(params[:id])
    
    gon.contact_types = @contact_types
    gon.contact = @contact
    gon.companies = @companies
    gon.contact_phones = @contact.phones.to_json(:include => [])
    gon.contact_emails = @contact.emails.to_json(:include => [])
    gon.contact_addresses = @contact.addresses.to_json(:include => [])
    gon.contact_urls = @contact.urls.to_json(:include => [])
    
    respond_to do |format|
      format.html {
        @contact.contact_type_key = ContactType.find_by_name("Person").pub_key
      }
      format.json {
        @contact.contact_type_key = ContactType.find_by_name("Person").pub_key
        render :json => @contact.to_json()
      }
    end
    
  end
  
  def update
    respond_to do |format|
      format.html {
        if (params[:contact][:company_key].nil? || params[:contact][:company_key] == "") && (!params[:contact][:company_name].nil? && params[:contact][:company_name] != "")
          @company = Contact.companies.create(name: params[:contact][:company_name])
          @company.save
          @company_key = @company.pub_key
        else
          @company_key = params[:contact][:company_key]
        end
        
        @contact = Contact.find_by_pub_key(params[:id])
        if @contact
          @contact.name = params[:contact][:name]
          @contact.title = params[:contact][:title]
          @contact.company_key = @company_key
          @contact.contact_type_key = params[:contact][:contact_type_key]
        
          if @contact.save
            if params[:phones]
              params[:phones].each do |phone|
                if phone[:pub_key].nil? || phone[:pub_key] == ""
                  @contact.phones.create!(name: phone[:name], val: phone[:val])
                else
                  @contact_phone = ContactPhone.find_by_pub_key(phone[:pub_key])
                  if @contact_phone
                    @contact_phone.name = phone[:name]
                    @contact_phone.val = phone[:val]
                    @contact_phone.save
                  end
                end
              end
            end
            
            if params[:emails]
              params[:emails].each do |email|
                if email[:pub_key].nil? || email[:pub_key] == ""
                  @contact.emails.create!(name: email[:name], val: email[:val])
                else
                  @contact_email = ContactEmail.find_by_pub_key(email[:pub_key])
                  if @contact_email
                    @contact_email.name = email[:name]
                    @contact_email.val = email[:val]
                    @contact_email.save
                  end
                end
              end
            end
            
            if params[:urls]
              params[:urls].each do |url|
                if url[:pub_key].nil? || url[:pub_key] == ""
                  @contact.urls.create!(name: url[:name], val: url[:val])
                else
                  @contact_url = ContactUrl.find_by_pub_key(url[:pub_key])
                  if @contact_url
                    @contact_url.name = url[:name]
                    @contact_url.val = url[:val]
                    @contact_url.save
                  end
                end
              end
            end
            
            if params[:addresses]
              params[:addresses].each do |address|
                if address[:pub_key].nil? || address[:pub_key] == ""
                  @contact.addresses.create!(name: address[:name], street1: address[:street1])
                else
                  @contact_address = ContactAddress.find_by_pub_key(address[:pub_key])
                  if @contact_address
                    @contact_address.name = address[:name]
                    @contact_address.street1 = address[:street1]
                    @contact_address.city = address[:city]
                    @contact_address.state = address[:state]
                    @contact_address.zip = address[:zip]
                    @contact_address.country = address[:country]
                    @contact_address.save
                  end
                end
              end
            end
          end
          
          
          # @contacts = Contact.all
          #           @contact_types = ContactType.all
          # 
          #           if @contact.contact_type.name == "Company"
          #             @contact_type = "Company"
          #             @company_contacts = Contact.find_by_company_key(@contact.pub_key)
          #           else
          #             @contact_type = "Person"
          #             @company = @contact.company
          #           end
          # 
          #           gon.contact_types = @contact_types
          #           gon.contacts = @contacts
          
          flash[:success] = "Contact updated"
          # redirect_to contact_path(params[:id])
          redirect_to contact_path(@contact.pub_key)
        else
          @account_key = @current_user.account_key
          @contact_types = ContactType.all
          @companies = Contact.companies
          @contact = Contact.find_by_pub_key(params[:id])

          gon.contact_types = @contact_types
          gon.contact = @contact
          gon.companies = @companies
          gon.contact_phones = @contact.phones.to_json(:include => [])
          gon.contact_emails = @contact.emails.to_json(:include => [])
          gon.contact_addresses = @contact.addresses.to_json(:include => [])
          gon.contact_urls = @contact.urls.to_json(:include => [])
          
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
  
  
  def destroy
    respond_to do |format|
      format.html {
        @contact = Contact.find_by_pub_key(params[:id])
        @contact.destroy
        redirect_back_or contacts_path
      }
      format.json {
        @contact = Contact.find_by_pub_key(params[:id])      
        if @contact.destroy
          render :json => @contact
        else
          render :json => "false"
        end
      }
    end
  end
end