class MilestonesController < ApplicationController
  before_filter :signed_in!, :check_disabled!
    
      def new
        
      end
      
      def create
        
      end
      
      def index
        respond_to do |format|
          format.html {
            @milestones = Milestone.all
          }
          format.json { 
            @milestones = Milestone.all
            render :json => @milestones
          }
        end
      end
      
      def show
        respond_to do |format|
          format.html {
            @milestone = Milestone.find_by_pub_key(params[:id])
          }
          format.json {
            @milestone = Milestone.find_by_pub_key(params[:id]) 
            render :json => @milestone
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
