class Teacher < ActiveRecord::Base
    has_secure_password
    validates :email, presence: true
    validates :password, presence: true
    validates :email, uniqueness: true

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |teacher|
            teacher.image = auth.info.image
            teacher.first_name = auth.info.first_name
            teacher.last_name = auth.info.last_name
            teacher.email = auth.info.email
            # coach.password = SecureRandom.hex
        end
    end

end
