class UserCountry < ActiveRecord::Base
    belongs_to :user
    belongs_to :country
    validates :country_id, :uniqueness => {:scope => :user_id}


end