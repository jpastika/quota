class MembersController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  
  def index
    @members = current_member.account.members
  end
  
  def new
    @member = Member.new
    @member.build_user
    #@user = User.new
  end
  
  def show
    respond_to do |format|
      format.html {
        @member = current_member
      }
      format.json {
        @member = current_member 
        render :json => @member.to_json
      }
    end
  end
  
  def create
    @member = Member.new(params[:member])
    @member.user = User.new(params[:user])
    existing_user = User.find_by_email(params[:user][:email])
    
    if existing_user
      current_member.account.memberize!(existing_user)
      flash[:success] = "#{existing_user.name} is now a member of your Quota account."
      redirect_to members_path
    else
      if @member.user.save
        current_member.account.memberize!(@member.user)
        flash[:success] = "#{@member.user.name} is now a member of your Quota account."
        redirect_to members_path
      else
        render 'new'
      end
    end
  end
  
  def edit
    @member = Member.find_by_pub_key(params[:id])
  end
  
  def update
    @member = Member.find_by_pub_key(params[:id])
    if @member.update_attributes(params[:member])
      flash[:success] = "Member updated"
      redirect_to members_path
    else
      render 'edit'
    end
  end
end
