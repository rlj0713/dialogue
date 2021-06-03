class User < ActiveRecord::Base
    def self.from_omniauth(auth)
        p auth.info
        where(email: auth.info.email).first_or_initialize do |user|
            user.image = auth.info.image
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name
            user.email = auth.info.email
            # user.password = SecureRandom.hex
        end
    end
end
