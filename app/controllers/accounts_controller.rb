class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.users.build
  end
  
  def create
    #Check for an existing user
    user = User.find_by_email(params[:account][:users_attributes]["0"][:email])
    
    if user != nil
      params[:account].delete :users_attributes
      @account = Account.new(params[:account])
      if @account.save
        @account.memberize!(user)
        sign_in @account.members.last
        flash[:success] = "Welcome to Quota!"
        redirect_to dashboard_path
      else
        render 'new'
      end
    else
      @account = Account.new(params[:account])
      if @account.save
        sign_in @account.members.last
        flash[:success] = "Welcome to Quota!"
        redirect_to dashboard_path
      else
        render 'new'
      end
    end
  end
end
