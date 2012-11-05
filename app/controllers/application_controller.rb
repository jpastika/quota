class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  around_filter :scope_current_user
  around_filter :scope_current_account
  
private
  
  def scope_current_account
    Account.current_account_key = current_user ? current_user.account.pub_key : nil
    yield
  ensure
    Account.current_account_key = nil
  end
  
  def scope_current_user
    User.current_user_key = current_user ? current_user.pub_key : nil
    yield
  ensure
    User.current_user_key = nil
  end
end
