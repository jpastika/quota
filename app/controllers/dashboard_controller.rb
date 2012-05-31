class DashboardController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  
  def index
  end
end
