class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    if(session[:user_id])
      user = User.find(session[:user_id]) 
      @current_user ||= user if(session[:user_id] && (session[:authentication_token] == user.authentication_token))
    end
  end
  def authorize
    redirect_to '/login' unless current_user
  end
  def find_group
    @group = Group.find(params[:id]) 
  end
end
