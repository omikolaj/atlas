class Country < ActiveRecord::Base
    has_many :user_countries
    has_many :users, through: :user_countries
    validates :name, presence: true, uniqueness: { case_sensitive: false }


    def self.create_from_api(name)
        path = "https://restcountries.eu/rest/v2/all"
        data = JSON.parse(RestClient.get(path, headers={}))
        binding.pry
    end

    def self.countries
        path = "public/img/flags/"
        @flags ||= Dir.glob("#{path}*.svg").collect do |flag|
            flag.gsub("#{path}","").gsub(".svg", "")
        end
    end
    
end