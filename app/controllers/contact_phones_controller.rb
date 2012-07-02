class ContactPhonesController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  
  def index
    respond_to do |format|
      @contact = Contact.find_by_pub_key(params[:id])
      @contact_phones = @contact.phones
      format.html {
        
      }
      format.json { 
        render :json => @contact_phones
      }
    end
  end
  
  def show
    
  end
  
  def new
    
  end
  
  def create
   
  end
  
  def edit
    
  end
  
  def update
    
  end
end