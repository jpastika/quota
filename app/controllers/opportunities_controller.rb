class OpportunitiesController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  respond_to :html, :json
  
  def index
    @opportunities = current_user.account.opportunities
    respond_to do |format|
      format.html {
        @account_key = @current_user.account.pub_key
        @opportunities = Opportunity.find(:all, :conditions => {:account_key => @account_key})
        
        gon.opportunities = @opportunities.to_json(:include => [:milestone, :owner, :company])
        gon.current_member = @current_user
      }
      format.json { 
        @account_key = @current_user.account.pub_key
        @opportunities = Opportunity.find(:all, :conditions => {:account_key => @account_key})
        
        render :json => @opportunities.to_json(:include => [:milestone, :owner, :company])
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
    @account_key = @current_user.account_key
    @companies = Contact.companies(@current_user.account)
    @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
    @sales_reps = SalesRep.where(:account_key => @current_user.account.pub_key)
    
    gon.companies = @companies
    gon.milestones = @milestones
    gon.sales_reps = @sales_reps
    
    @opportunity = Opportunity.new
    
    gon.opportunity = @opportunity
  end
  
  def create
    @opportunity = current_user.created_opportunities.build(params[:opportunity])
    @opportunity.account = current_user.account
    @opportunity.owner = current_user
    
    if (@opportunity.company_key.nil? || @opportunity.company_key == "") && (!params[:customer][:company_name].nil? && params[:customer][:company_name] != "")
      @company = current_user.account.contacts.companies(current_user.account).build(name: params[:customer][:company_name])
      if @company.save
        @opportunity.company_key = @company.pub_key
      end
    end
    
    if @opportunity.save
      flash[:success] = "Item created!"
      redirect_to opportunity_path(@opportunity.pub_key)
    else
      @account_key = @current_user.account_key
      @companies = Contact.companies(@current_user.account)
      @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
      @sales_reps = SalesRep.where(:account_key => @current_user.account.pub_key)

      gon.companies = @companies
      gon.milestones = @milestones
      gon.sales_reps = @sales_reps
      
      gon.opportunity = @opportunity
      
      render 'new'
    end
  end
  
  def edit
    @account_key = @current_user.account_key
    @companies = Contact.companies(@current_user.account)
    @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
    @sales_reps = SalesRep.where(:account_key => @current_user.account.pub_key)
    
    gon.companies = @companies
    gon.milestones = @milestones
    gon.sales_reps = @sales_reps
    
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    
    gon.opportunity = @opportunity
  end
  
  def update
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    
    # if @opportunity.company_key.nil?
      # if !params[:opportunity][:company_name].nil? && params[:opportunity][:company_name] != ""
        
      # end
    # end
    
    if @opportunity.update_attributes(params[:opportunity])
      if (@opportunity.company_key.nil? || @opportunity.company_key == "") && (!params[:customer][:company_name].nil? && params[:customer][:company_name] != "")
        @company = current_user.account.contacts.companies(current_user.account).build(name: params[:customer][:company_name])
        if @company.save
          @opportunity.company_key = @company.pub_key
        
          if @opportunity.save
            flash[:success] = "Opportunity updated"
            redirect_to opportunity_path(@opportunity.pub_key)
          end
        end
      else
        flash[:success] = "Opportunity updated"
        redirect_to opportunity_path(@opportunity.pub_key)
      end
    else
      @account_key = @current_user.account_key
      @companies = Contact.companies(@current_user.account)
      @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
      @sales_reps = SalesRep.where(:account_key => @current_user.account.pub_key)

      gon.companies = @companies
      gon.milestones = @milestones
      gon.sales_reps = @sales_reps
      gon.opportunity = @opportunity
      render 'edit'
    end
  end
  
  def destroy
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    @opportunity.destroy
    redirect_back_or opportunities_path
  end
end
