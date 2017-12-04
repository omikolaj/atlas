class Country < ActiveRecord::Base
    has_many :user_countries
    has_many :users, through: :user_countries
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    
    @@matches = []
    @@mis = []

    def self.matches
        @@matches
    end

    def self.mis
        @@mis
    end

    def self.populate_data_from_api
        path = "https://restcountries.eu/rest/v2/all"
        data = JSON.parse(RestClient.get(path, headers={}))
    end

    def self.country_names
        path = "public/img/flags/"
        flags ||= Dir.glob("#{path}*.svg").collect{|flag| flag.gsub("#{path}","").gsub(".svg", "")}
    end

    def self.filter
        Country.country_names.each{|country| Country.matches?(country) ? @@matches << country : @@mis << country}       
    end

    def self.matches?(country)
        @api_countries ||= Country.populate_data_from_api
        @api_countries.map{|country| country["name"]}.any?{|api| api.include?(country)}       
    end

    def self.create_flag_country_hash
        country_flags = {}
        Country.filter
        Country.matches.map{|country| country_flags[:"#{country}"] = "public/img/flags/#{country}.svg"}
        binding.pry
    end
    
end