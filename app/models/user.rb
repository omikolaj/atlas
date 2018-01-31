class User < ActiveRecord::Base
    has_many :user_countries
    has_many :countries, through: :user_countries
    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true
    before_save :downcase_fields


    def self.find_or_create_guest
        self.where(:username => "robertgreene").first_or_create do |guest|
            guest.username = "robertgreene"
            guest.password = SecureRandom.hex
            guest.email = "robert.greene@gmail.com"
        end
    end

    def downcase_fields
        self.username.downcase!
        self.email.downcase!
    end

    def slug 
        username.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug}
    end

end