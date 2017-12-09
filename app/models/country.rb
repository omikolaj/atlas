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

    def self.create_from_api_data(name)
        path = URI.encode("https://restcountries.eu/rest/v2/name/#{name}?fullText=true")
        data = JSON.parse(RestClient.get(path, headers={}))
        country = Country.create
        country.name = name
        country.topLevelDomain = data[0]["topLevelDomain"]
        country.alpha2Code = data[0]["alpha2Code"]
        country.alpha3Code = data[0]["alpha3Code"]
        country.callingCodes = data[0]["callingCodes"]
        country.capital = data[0]["capital"]
        country.region = data[0]["region"]
        country.subregion = data[0]["subregion"]
        country.demonym = data[0]["demonym"]
        country.area = data[0]["area"]
        country.timezones = data[0]["timezones"]
        country.borders = data[0]["borders"]
        country.nativeName = data[0]["nativeName"]
        country.currency_name = data[0]["nativeName"]
        country.currency_symbol = data[0]["currencies"][0]["symbol"]
        country.native_lang_name = data[0]["languages"][0]["nativeName"]
        country.language_name = data[0]["languages"][0]["name"]
        country.flag_path = data[0]["flag"]
        country.save
        country
    end

    def self.find_or_create_from_api(name)
        find_by(name: name) || find_by_slug(name) || create_from_api_data(name)
    end

    def self.create_flag_country_hash
        country_flags = {}
        Country.matches.map{|country_name| country_flags[:"#{country_name}"] = "public/img/flags/#{country_name}.svg"}
    end


    def self.country_names
        path = "public/img/flags/"
        flags ||= Dir.glob("#{path}*.svg").collect{|flag| flag.gsub("#{path}","").gsub(".svg", "")}
    end

    def slug 
        name.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        Country.all.find{|country| country.slug == slug}
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
        @@matches.sort{|a,b| a<=>b}
    end
    

    def self.matches?(country)
        @api_countries ||= Country.populate_data_from_api
        @api_countries.map{|country| country["name"]}.any?{|api| api.include?(country)}       
    end
    
end