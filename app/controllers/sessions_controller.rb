class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if params[:coach_permission].to_i == 0
      session[:coach_permission] = false
      render '/teachers/new'
    else
      session[:coach_permission] = true
      render '/coaches/new'
    end
  end
  
  def destroy
    session.delete('user_id')
    redirect_to root_path
  end

  def show
    @user = Coach.find_by(:email => params[:email]) || Teacher.find_by(:email => params[:email]) 
    if @user.authenticate(params[:password]) && @user.coach_permission
			session[:user_id] = @user.id
			redirect_to "/coaches/#{@user.id}"
		elsif @user.authenticate(params[:password]) && @user.coach_permission == false
      session[:user_id] = @user.id
			redirect_to "/teachers/#{@user.id}"
    else
			redirect_to root_path
		end
  end
  
  private
  
  # Oauth specfic log-in method
  def auth
    request.env['omniauth.auth']
  end

end