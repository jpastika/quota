class UsersController < ApplicationController
  before_filter [:signed_in_member!, :check_disabled!], :only => :show 
  
  def show
    respond_to do |format|
      format.html {
        @user = current_user
      }
      format.json {
        @user = current_user 
        render :json => @user.to_json
      }
    end
  end
  
  def new
    
  end
end
