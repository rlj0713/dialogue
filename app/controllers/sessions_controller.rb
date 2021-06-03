class SessionsController < ApplicationController

  def create
    if User.find_by(auth['uid'])
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.image = auth['info']['image']
      end
    else
      byebug
    end
    
    session[:user_id] = @user.id
    render 'sessions/home'
  end

  def signup
    render 'sessions/signup'
  end
  
  def destroy
    session.delete('user_id')
    redirect_to root_path
  end
  
  private
  
  # Oauth specfic log-in method
  def auth
    request.env['omniauth.auth']
  end

end