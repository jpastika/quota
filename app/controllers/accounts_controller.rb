class AccountsController < ApplicationController
  before_filter [:signed_in_member!, :check_disabled!], :only => :show 
  
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
        @account.memberize!(user)
        @account.repize!(@account.members.last)
        sign_in @account.members.last
        flash[:success] = "Welcome to Quota..."
        redirect_to dashboard_path
      else
        render 'new'
      end
    else
      @account = Account.new(params[:account])
      if @account.save
        sign_in @account.members.last
        @account.repize!(@account.members.last)
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
        @account = current_member.account
      }
      format.json {
        @account = current_member.account 
        render :json => @account.to_json
      }
    end
  end
end
