class ApplicationController < ActionController::Base
    def current_user
        Coach.find_by(id: session[:user_id])
    end
end
