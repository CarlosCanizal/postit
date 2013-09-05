class SessionsController < ApplicationController


  def new
  end

  def user_success(user)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def create
    user = User.find_by_username(params[:username])
    if user.authenticate(params[:password])
      if user.two_factor_auth?
        user.generate_pin!
        #user.send_pin_to_twilio
        session[:pin] = true
        redirect_to pin_path
      else
        user_success(user)
      end
    else
      flash[:notice] = 'Invalid username or password.'
      render 'new'
    end

  end

  def pin
    if session[:pin]
      if request.post?
        user = User.find_by(pin:params[:pin])
        if user
          user.remove_pin!
          session[:pin] = false
          user_success(user)
        else
          flash[:error] = 'Invalid PIN'
          redirect_to pin_path
        end
      end
    else
      flash[:error] = 'You can\'t do that.'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end


end