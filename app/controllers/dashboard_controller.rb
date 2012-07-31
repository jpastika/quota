class DashboardController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def index
  end
end
