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
    @opportunity = Opportunity.find_by_pub_key(params[:opportunity_key])
    @contact = Contact.find_by_pub_key(params[:contact_key])
    
    respond_to do |format|
      format.html {
        @opportunity_contact = OpportunityContact.build(contact_key: params[:contact_key], opportunity_key: params[:opportunity_key])
        if @opportunity_contact.save
          flash[:success] = "#{@opportunity_contact.name} saved."
          redirect_to contacts_path
        else
          render 'new'
        end
      }
      format.json {
        if @opportunity and @contact
          @opportunity_contact = OpportunityContact.build(contact_key: params[:contact_key], opportunity_key: params[:opportunity_key])
          if @opportunity_contact.save
            render :json => @opportunity_contact.to_json(:include => {:contact => {:include => [:phones, :emails, :company]}})
          else
            render :json => "false", :status => :unprocessable_entity
          end
        else
          render :json => "false", :status => :unprocessable_entity
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
    respond_to do |format|
      # format.html {
      #         @opportunity_contact = OpportunityContact.find_by_pub_key(params[:id])
      #         if @opportunity_contact.destroy
      #           flash[:success] = "Contact removed"
      #           redirect_to opportunities_path
      #         else
      #           render 'edit'
      #         end
      #       }
      format.json {
        @opportunity_contact = OpportunityContact.find_by_pub_key(params[:id])      
        if @opportunity_contact.destroy
          render :json => @opportunity_contact
        else
          render :json => "false"
        end
      }
    end
  end
end