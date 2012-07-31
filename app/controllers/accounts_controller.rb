class AccountsController < ApplicationController
  before_filter [:signed_in!, :check_disabled!], :only => :show 
  
  def new
    @account = Account.new
    @account.users.build
    
    render layout: "public"
  end
  
  def create
    #Check for an existing user
    user = User.find_by_email(params[:account][:users_attributes]["0"][:email])
    
    if user != nil
      params[:account].delete :users_attributes
      @account = Account.new(params[:account])
      if @account.save
        @account.repize!(user)
        sign_in user
        flash[:success] = "Welcome to Quota..."
        redirect_to dashboard_path
      else
        render 'new'
      end
    else
      @account = Account.new(params[:account])
      if @account.save
        sign_in @account.users.last
        @account.repize!(@account.users.last)
        flash[:success] = "Welcome to Quota!!!"
        redirect_to dashboard_path
      else
        render 'new'
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        @account = current_user.account
      }
      format.json {
        @account = current_user.account 
        render :json => @account.to_json
      }
    end
  end
end
