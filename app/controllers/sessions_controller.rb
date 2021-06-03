class SessionsController < ApplicationController
  # config.middleware.insert_after ActiveRecord::Migration::CheckPending, ActionDispatch::Cookies
  # config.middleware.insert_after ActionDispatch::Cookies, ActionDispatch::Session::CookieStore
    
  def GoogleAuth
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    session[:user_id] = user.id
    byebug
    user.google_token = access_token.credentials.token
    # p user
    user.save
  end

    def create
      if User.find_by(auth['uid'])
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.image = auth['info']['image']
      end
    end
  
      session[:user_id] = @user.id
      render 'sessions/home'
    end

    def login
      render 'sessions/login'
    end

    def destroy
      session.delete('user_id')
      redirect_to root_path
    end

    private
  
    def auth
      request.env['omniauth.auth']
    end
end