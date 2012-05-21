class MembersController < ApplicationController
  
  def index
    @members = current_member.account.members
  end
  
  def new
    @member = Member.new
    @member.build_user
    #@user = User.new
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
end
