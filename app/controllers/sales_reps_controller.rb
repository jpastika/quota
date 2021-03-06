class SalesRepsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def index
    respond_to do |format|
      format.html {
        @reps = SalesRep.all
      }
      format.json { 
        @reps = SalesRep.all
        render :json => @reps
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        @rep = SalesRep.find_by_pub_key(params[:id])
      }
      format.json {
        @rep = SalesRep.find_by_pub_key(params[:id]) 
        render :json => @rep
      }
    end
  end
  
  def new
    @rep = SalesRep.new
  end
  
  def create
    @rep = SalesRep.build(params[:sales_rep])
    
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