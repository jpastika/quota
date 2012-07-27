class OpportunitiesController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  respond_to :html, :json
  
  def index
    @opportunities = current_member.account.opportunities
    respond_to do |format|
      format.html {
        @account_key = @current_member.account.pub_key
        @opportunities = Opportunity.where(:account_key => @account_key)
        
        gon.opportunities = @opportunities
        gon.current_member = @current_member
      }
      format.json { 
        @account_key = @current_member.account.pub_key
        @opportunities = Opportunity.where(:account_key => @account_key)
        
        render :json => @opportunities.to_json()
      }
    end
  end
  
  def show
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    respond_to do |format|
      format.html {
        @opportunity = Opportunity.find_by_pub_key(params[:id])
        
        gon.opportunity = Opportunity.find_by_pub_key(params[:id])
      }
      format.json {
        @opportunity = Opportunity.find_by_pub_key(params[:id])
        
        render :json => @opportunity
      }
    end
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
