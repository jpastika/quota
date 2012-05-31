class SessionsController < ApplicationController
  layout "public"
  
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if current_member != nil
        sign_in current_member
        redirect_back_or dashboard_path
      else
        if user.members.count > 1
          set_current_user user
          redirect_to choose_account_path 
        else
          sign_in user.members.first
          redirect_back_or dashboard_path
        end
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  def choose
    
  end
  
  def switch_account
    if current_user != nil
      account = Account.find_by_pub_key(params[:id])
      
      if account != nil
        sign_in account.members.find_by_user_key(current_user.pub_key)
        
        redirect_to dashboard_path
      end
    else
      redirect_to signin_path
    end
  end
end
