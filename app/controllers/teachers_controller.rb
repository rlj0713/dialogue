class TeachersController < ApplicationController
    protect_from_forgery with: :null_session
    
    def create
        if auth == nil
          @teacher = Teacher.new do |t|
            t.email = params[:email]
            t.password = params[:password]
            t.first_name = params[:first_name]
            t.last_name = params[:last_name]
            t.coach_permission = false
          end
          @teacher.save
        elsif Teacher.find_by(auth['uid'])
          @teacher = Teacher.find_or_create_by(uid: auth['uid']) do |t|
            t.name = auth['info']['name']
            t.image = auth['info']['image']
            t.coach_permission = false
          end
        else
          redirect_to 'sessions/login'
        end
        
        session[:user_id] = @teacher.id
        redirect_to '/posts'
    end

    # def new
    #   session[:coach_permission] = false
    # end
    

    private

    # Oauth specfic log-in method
    def auth
        request.env['omniauth.auth']
    end
end
