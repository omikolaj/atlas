class CountryController < ApplicationController

    get '/countries' do
        if logged_in?
            @flags ||= Country.matches
            erb :"country/countries"
        else
            redirect '/login'
        end
    end

    get '/countries/:country' do
        if logged_in?
            @country = Country.find_or_create_from_api(params["country"])
            erb :"country/show"
        else
            redirect '/login'
        end
    end

end