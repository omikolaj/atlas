class Country < ActiveRecord::Base
    has_many :user_countries
    has_many :users, through: :user_countries
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    
    def self.create_from_api_data(data)
        country = self.create
        country.name = data["name"]
        country.topLevelDomain = data["topLevelDomain"]
        country.alpha2Code = data["alpha2Code"]
        country.alpha3Code = data["alpha3Code"]
        country.callingCodes = data["callingCodes"]
        country.capital = data["capital"]
        country.region = data["region"]
        country.subregion = data["subregion"]
        country.demonym = data["demonym"]
        country.area = data["area"]
        country.timezones = data["timezones"]
        country.borders = data["borders"]
        country.nativeName = data["nativeName"]
        country.currency_name = data["nativeName"]
        country.currency_symbol = data["currencies"][0]["symbol"]
        country.native_lang_name = data["languages"][0]["nativeName"]
        country.language_name = data["languages"][0]["name"]
        country.flag_path = data["flag"]
        country.save
        country
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
    
    def self.load
        Country.all.empty? ? matches? : all
    end

    def self.matches?
        @api_countries ||= Country.populate_data_from_api
        @api_countries.map do |api_country|
           if country_names.include?(api_country["name"])
                
          end
        end
        all
    end    
end