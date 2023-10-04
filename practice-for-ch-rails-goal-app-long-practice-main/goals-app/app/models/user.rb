# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    before_validation :ensure_session_token
    validates :username, :password_digest, :session_token, presence:true
    validates :username, uniqueness:true
    validates :password, length: {minimum: 6, allow_nil:true}

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def is_password?(password)
        po = BCrypt::Password.new(self.password_digest)
        po.is_password?(password)
    end

    attr_reader :password
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end


end
