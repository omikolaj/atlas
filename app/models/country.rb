class Country < ActiveRecord::Base
    has_many :user_countries
    has_many :users, through: :user_countries
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    
    @@matches = []
    @@mis = []

    def self.matches
        @@matches.empty? ? Country.worker : @@matches
    end

    def self.mis
        @@mis
    end

    def self.create_flag_country_hash
        country_flags = {}
        Country.matches.map{|country_name| country_flags[:"#{country_name}"] = "public/img/flags/#{country_name}.svg"} 
    end

    def self.country_names
        path = "public/img/flags/"
        flags ||= Dir.glob("#{path}*.svg").collect{|flag| flag.gsub("#{path}","").gsub(".svg", "")}
    end

    private

    def self.populate_data_from_api
        path = "https://restcountries.eu/rest/v2/all"
        data = JSON.parse(RestClient.get(path, headers={}))
    end
    

    def self.filter
        Country.country_names.each{|country| Country.matches?(country) ? @@matches << country : @@mis << country}       
    end
    

    def self.worker
        Country.filter
        @@matches
    end
    

    def self.matches?(country)
        @api_countries ||= Country.populate_data_from_api
        @api_countries.map{|country| country["name"]}.any?{|api| api.include?(country)}       
    end
    
end