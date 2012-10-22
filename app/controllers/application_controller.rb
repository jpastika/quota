class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  around_filter :scope_current_account
  
private
  
  def scope_current_account
    Account.current_account_key = current_user.account.pub_key
    yield
  ensure
    Account.current_account_key = nil
  end
end
