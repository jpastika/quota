class OpportunitiesController < ApplicationController
  
  def index
    @opportunities = current_member.account.opportunities
    @my_created_opportunities = @opportunities.where(:owner_key => current_member.pub_key)
    @my_owned_opportunities = @opportunities.where(:creator_key => current_member.pub_key)
  end
  
  def show
    @opportunity = Opportunity.find_by_pub_key(params[:id])
  end
  
  def new
    @opportunity = Opportunity.new
  end
  
  def create
    @opportunity = current_member.created_opportunities.build(params[:opportunity])
    @opportunity.account = current_member.account
    @opportunity.owner = current_member
    if @opportunity.save
      flash[:success] = "Item created!"
      redirect_to opportunities_path
    else
      render 'new'
    end
  end
  
  def edit
    @opportunity = Opportunity.find_by_pub_key(params[:id])
  end
  
  def update
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    if @opportunity.update_attributes(params[:opportunity])
      flash[:success] = "Opportunity updated"
      redirect_to opportunities_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    @opportunity.destroy
    redirect_back_or opportunities_path
  end
end
