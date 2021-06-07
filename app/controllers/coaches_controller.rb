class CoachesController < ApplicationController
    protect_from_forgery with: :null_session

    def create
        if auth == nil
          @coach = Coach.new do |c|
            c.email = params[:email]
            c.password = params[:password]
            c.first_name = params[:first_name]
            c.last_name = params[:last_name]
            c.coach_permission = true
          end
          @coach.save
        elsif Coach.find_by(auth['uid'])
          @coach = Coach.find_or_create_by(uid: auth['uid']) do |c|
            c.name = auth['info']['name']
            c.image = auth['info']['image']
          end
        else
          redirect_to 'sessions/login'
        end
        
        session[:user_id] = @coach.id
        render 'teachers/index'
    end

    def new
    end

    def show
        @coach = Coach.find_by(email: params[:email])
        @teacher = Teacher.find_by(email: params[:email])
        if @coach.authenticate(params[:password])
            session[:user_id] = @coach.id
            render 'teachers/index'
        elsif @teacher.authenticate(params[:password])
            session[:user_id] = @teacher.id
            redirect_to @post
        else
            redirect_to root_path
        end
    end

    # Oauth specfic log-in method
    def auth
        request.env['omniauth.auth']
    end
end
