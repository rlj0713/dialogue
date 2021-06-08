class OacoachesController < ApplicationController
    def create
        @coach = Coach.find_or_create_by(uid: auth['uid']) do |c|
            c.first_name = auth['info']['name']
            c.image = auth['info']['image']
        end
        @coach.save
    end

    session[:user_id] = @coach.uid
    redirect_to '/teachers'
end