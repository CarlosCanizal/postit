class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method [:current_user, :logged_in?, :access_denied]

  def current_user
    @user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def access_denied
    redirect_to root_path unless logged_in?
  end

  def already_voted? obj
    current_user.votes.find_by(votable:obj)
  end

end
