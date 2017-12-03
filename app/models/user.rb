class User < ActiveRecord::Base
    has_many :user_countries
    has_many :countries, through: :user_countries
    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true
end