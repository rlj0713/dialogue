class Coach < ActiveRecord::Base
    has_secure_password
    # validates :email, presence: true
    # validates :password, presence: true
    # validates :email, uniqueness: true

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |coach|
            coach.image = auth.info.image
            coach.first_name = auth.info.first_name
            coach.last_name = auth.info.last_name
            coach.email = auth.info.email
            # coach.password = SecureRandom.hex
        end
    end

end
