class CountryController < ApplicationController

    get '/countries' do
        if logged_in?
            @flags ||= Country.country_names
            erb :"country/countries"
        else
            redirect '/login'
        end
    end
end