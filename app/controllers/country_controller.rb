class CountryController < ApplicationController

    get '/countries' do
        if logged_in?
            @flags ||= Country.countries
            erb :"country/countries"
        else
            redirect '/login'
        end
    end
end