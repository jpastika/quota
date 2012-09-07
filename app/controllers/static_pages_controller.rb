class StaticPagesController < ApplicationController
  layout 'public'
  
  def home
  end
  
  def map_test
    render :layout => false
  end
  
  def bridge
    render :layout => false
  end
end
