class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if auth == nil
      @user = User.new do |u|
        u.email = params[:email]
        u.password = params[:password]
        u.name = "#{params[:first_name]} #{params[:last_name]}"
        u.image = "https://static.thenounproject.com/png/1121885-200.png"
      end
      @user.save
    else
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.image = auth['info']['image']
      end
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