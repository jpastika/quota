class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.users.build
  end
  
  def create
    @account = Account.new(params[:account])
    if @account.save
      flash[:success] = "Welcome to Quota!"
      redirect_to dashboard_path
    else
      render 'new'
    end
  end
end
