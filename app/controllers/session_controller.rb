class SessionController < ApplicationController

  def create
    p "====================#{params[:session].inspect}"
    user = User.find_by_email(params[:session][:email])
    if user &&  user.authenticate(params[:session][:password])
      user.update_attribute(:authentication_token , Time.now.to_i.to_s+SecureRandom.hex)
      session[:user_id] = user.id
      session[:authentication_token] = user.authentication_token
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def new
       redirect_to root_path  if current_user 
  end

  def destroy
    session[:user_id] = nil
    session[:authentication_token] = nil
    redirect_to '/login'
  end


end
