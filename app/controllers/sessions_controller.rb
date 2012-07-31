class SessionsController < ApplicationController
  layout "public"
  
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user
      if user.is_disabled?
        flash[:error] = "You are not able to access this account."
        render 'new'
      else
        if user.authenticate(params[:session][:password])
          if current_user && (current_user.is_disabled? || current_user.account.is_disabled?)
            flash[:error] = "You are not able to access this account."
            render 'new'
          else
            sign_in user
            redirect_back_or dashboard_path
          end
        else
          flash.now[:error] = 'Invalid email/password combination'
          render 'new'
        end
      end
    else
      flash.now[:error] = 'Invalid email/password combination123'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  def choose
    
  end
end
