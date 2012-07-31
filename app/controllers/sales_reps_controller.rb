class SalesRepsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def index
    @reps = current_user.account.sales_reps
  end
  
  def new
    @rep = current_user.account.sales_reps.build()
  end
  
  def create
    @rep = current_user.account.sales_reps.build(params[:sales_rep])
    
    if @rep.save
      flash[:success] = "#{@rep.name} is now a rep on your Quota account."
      redirect_to sales_reps_path
    else
      render 'new'
    end
  end
  
  def edit
    @rep = SalesRep.find_by_pub_key(params[:id])
  end
  
  def update
    @rep = SalesRep.find_by_pub_key(params[:id])
    if @rep.update_attributes(params[:sales_rep])
      flash[:success] = "Rep updated"
      redirect_to sales_reps_path
    else
      render 'edit'
    end
  end
end