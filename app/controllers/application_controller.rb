class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    # ✅ Allows access to login and signup pages without causing infinite redirects
    unless session[:user_id] || request.path == login_path || request.path == new_user_path
      flash[:alert] = "You must be logged in."
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user
end
