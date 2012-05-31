module SessionsHelper
  
  def sign_in(member)
    cookies.permanent[:remember_token] = member.remember_token
    cookies.permanent[:user_key] = member.user.pub_key
    current_member = member
    current_user = member.user
  end
  
  def signed_in?
    !current_member.nil?
  end
  
  def sign_out
    current_user = nil
    current_member = nil
    cookies.delete(:remember_token)
    cookies.delete(:user_key)
  end
  
  def set_current_user(user)
    cookies.permanent[:user_key] = user.pub_key
    current_user = user
  end
  
  #def current_user=(user)
  #  @current_user = user
  #end
  
  #def current_member=(member)
  #  @current_member = member
  #  @current_user = member.user
  #end
  
  def current_member
    @current_member ||= member_from_remember_token
  end
  
  def current_user
    @current_user ||= user_from_user_key
  end
  
  def current_member?(member)
    member == current_member
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def signed_in_member!
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end
  end
  
  def check_disabled!
    if current_member && current_member.is_disabled?
      flash[:error] = "You are no longer able to access this account."
      redirect_to login_path
    end
  end
  
  private
    def member_from_remember_token
      remember_token = cookies[:remember_token]
      Member.find_by_remember_token(remember_token) unless remember_token.nil?
    end
    
    def user_from_user_key
      user_key = cookies[:user_key]
      User.find_by_pub_key(user_key) unless user_key.nil?
    end
    
    def clear_return_to
      session.delete(:return_to)
    end
end
