class ContactTypesController < ApplicationController
  before_filter :signed_in!, :check_disabled!
    
      def new
        
      end
      
      def create
        
      end
      
      def index
        respond_to do |format|
          format.html {
            @contact_types = current_user.account.contact_types
          }
          format.json { 
            @contact_types = current_user.account.contact_types
            render :json => @contact_types
          }
        end
      end
      
      def show
        respond_to do |format|
          format.html {
            @contact_type = ContactType.find_by_pub_key(params[:id])
          }
          format.json {
            @contact_type = ContactType.find_by_pub_key(params[:id]) 
            render :json => @contact_type
          }
        end
      end
      
      def edit
        
      end
      
      def update
        
      end
      
      def destroy
        
      end
end
