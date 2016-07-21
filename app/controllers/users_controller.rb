class UsersController < ApplicationController

  before_action :self_action, only:[:show,:destroy ,:edit ,:update]
  before_action :authorize, except:[:new,:create,:index]
  def index
   redirect_to new_user_path
  end
  def new
    @user = User.new
  end
  def show
  end
  def edit
  end
  def destroy
    session[:user_id] = nil
    @user.destroy
    redirect_to '/'
  end
  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:authentication_token] = @user.authentication_token
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new 
    end
  end
  def update 
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.' 
    else
      render :edit 
    end
  end

  private
  def user_params
    params[:user][:authentication_token] = Time.now.to_i.to_s+SecureRandom.hex
    params.require(:user).permit(:full_name,:username,:sex,:age,:email, :password, :password_confirmation,:image,:authentication_token)
  end
  def self_action
    @user = User.find(params[:id])
  end
end
