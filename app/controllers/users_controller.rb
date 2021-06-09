class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def create
        if auth == nil
          @user = User.new do |u|
            u.email = params[:email]
            u.password = params[:password]
            u.first_name = params[:first_name]
            u.last_name = params[:last_name]
          end
          @user.save
        else
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.first_name = auth['info']['name']
                u.image = auth['info']['image']
            end
            @user.save
        end
        
        session[:user_id] = @user.uid
        render 'teachers/index'
    end

    def show
        @user = User.find_by(email: params[:email])
        if @coach.authenticate(params[:password])
            session[:user_id] = @user.id
            render 'teachers/index'
        else
            redirect_to root_path
        end
    end

    # Oauth specfic log-in method
    def auth
        request.env['omniauth.auth']
    end
end
