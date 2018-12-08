class User < ActiveRecord::Base

    has_many :reviews
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, presence: true

end
