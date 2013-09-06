class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_action :get_user, only:[:show, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html {redirect_to login_path, notice:'Thanks for register, now login'}
        format.json {render json: @user}
        format.xml {render xml: @user}
      else
        format.html {render 'new'}
        format.json {render json: @user.errors}
        format.xml {render xml: @user.errors}
      end
    end
  end


  def show
  end

  private

  def get_user
    binding.pry
    @user = User.find_by(username:params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :time_zone, :phone)
  end


end