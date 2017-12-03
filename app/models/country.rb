class Country < ActiveRecord::Base
    has_many :user_countries
    has_many :users, through: :user_countries
    validates :name, presence: true, uniqueness: { case_sensitive: false }
end