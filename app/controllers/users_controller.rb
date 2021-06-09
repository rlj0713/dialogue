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
        else
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.first_name = auth['info']['name']
                u.image = auth['info']['image']
                u.password = auth['uid']
            end
        end
        @user.save
        session[:user_id] = @user.id
        render 'sessions/show'
    end

    def new
    end

    def show
        byebug
        @user = User.find_by(id: session[:user_id])
        # if @user.authenticate(params[:password])
        #     session[:user_id] = @user.id
            render 'users/show'
        # else
        #     redirect_to root_path
        # end
    end

    # Oauth specfic log-in method
    def auth
        request.env['omniauth.auth']
    end
end
