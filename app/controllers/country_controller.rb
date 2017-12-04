class CountryController < ApplicationController

    get '/countries' do
        if logged_in?
            @flags ||= Country.country_names
            erb :"country/countries"
        else
            redirect '/login'
        end
    end

    get '/countries/:country' do
        if logged_in?
            @country = Country.create_from_api_data(params["country"])
            erb :"country/show"
        else
            redirect '/login'
        end
    end

end