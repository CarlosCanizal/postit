class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    response = { errors: [error] }
    respond_to do |format|
      format.json { render json: response, status: :unprocessable_entity }
    end
  end




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

  def require_admin
    access_denied
    redirect_to root_path unless current_user.admin? 
  end

end
