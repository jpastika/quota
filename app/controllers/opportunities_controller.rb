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
        
        gon.opportunity = @opportunity.to_json(:include => [:milestone, :owner, :company])
        gon.opportunity_contacts = @opportunity.opportunity_contacts.to_json(:include => {:contact => {:include => [:phones, :emails, :company]}})
        gon.opportunity_documents = @opportunity.documents
        gon.companies = Contact.companies(@current_user.account)
        
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
    @users = User.where(:account_key => @current_user.account.pub_key)
    
    gon.companies = @companies
    gon.milestones = @milestones
    gon.users = @users
    
    @opportunity = Opportunity.new
    
    gon.opportunity = @opportunity
  end
  
  def create
    # handle is_sold checkbox
    if params[:opportunity][:is_sold] != "true"
      params[:opportunity][:is_sold] = false
    end
    
    # handle is_cancelled checkbox
    if params[:opportunity][:is_cancelled] != "true"
      params[:opportunity][:is_cancelled] = false
    end
    
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
      if !@opportunity.company_key.nil?
        current_user.account.opportunity_contacts.create!(opportunity_key: @opportunity.pub_key, contact_key: @opportunity.company_key)
      end
      
      flash[:success] = "Opportunity has been created"
      redirect_to opportunity_path(@opportunity.pub_key)
    else
      @account_key = @current_user.account_key
      @companies = Contact.companies(@current_user.account)
      @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
      @users = User.where(:account_key => @current_user.account.pub_key)

      gon.companies = @companies
      gon.milestones = @milestones
      gon.users = @users
      
      gon.opportunity = @opportunity
      
      render 'new'
    end
  end
  
  def edit
    @account_key = @current_user.account_key
    @companies = Contact.companies(@current_user.account)
    @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
    @users = User.where(:account_key => @current_user.account.pub_key)
    
    gon.companies = @companies
    gon.milestones = @milestones
    gon.users = @users
    
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    
    gon.opportunity = @opportunity
  end
  
  def update
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    
    # handle is_sold checkbox
    if params[:opportunity][:is_sold] != "true"
      params[:opportunity][:is_sold] = false
    end
    
    # handle is_cancelled checkbox
    if params[:opportunity][:is_cancelled] != "true"
      params[:opportunity][:is_cancelled] = false
    end
    
    if @opportunity.update_attributes(params[:opportunity])
      if (@opportunity.company_key.nil? || @opportunity.company_key == "") && (!params[:customer][:company_name].nil? && params[:customer][:company_name] != "")
        @company = current_user.account.contacts.companies(current_user.account).build(name: params[:customer][:company_name])
        if @company.save
          @opportunity.company_key = @company.pub_key
        
          if @opportunity.save
            if !@opportunity.company_key.nil? && OpportunityContact.where(:opportunity_key => @opportunity.pub_key, :contact_key => @opportunity.company_key).empty?
              current_user.account.opportunity_contacts.create!(opportunity_key: @opportunity.pub_key, contact_key: @opportunity.company_key)
            end
            
            flash[:success] = "Opportunity has been updated"
            redirect_to opportunity_path(@opportunity.pub_key)
          end
        end
      else
        if !@opportunity.company_key.nil? && OpportunityContact.where(:opportunity_key => @opportunity.pub_key, :contact_key => @opportunity.company_key).empty?
          current_user.account.opportunity_contacts.create!(opportunity_key: @opportunity.pub_key, contact_key: @opportunity.company_key)
        end
        
        flash[:success] = "Opportunity has been updated"
        redirect_to opportunity_path(@opportunity.pub_key)
      end
    else
      @account_key = @current_user.account_key
      @companies = Contact.companies(@current_user.account)
      @milestones = Milestone.where(:account_key => @current_user.account.pub_key)
      @users = User.where(:account_key => @current_user.account.pub_key)

      gon.companies = @companies
      gon.milestones = @milestones
      gon.users = @users
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
