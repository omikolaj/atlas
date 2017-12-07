class User < ActiveRecord::Base
    has_many :user_countries
    has_many :countries, through: :user_countries
    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true



    def add_country_to_dashboard(id)
        binding.pry
    end

    def slug 
        username.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug}
    end
end