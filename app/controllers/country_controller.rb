class CountryController < ApplicationController

    get '/countries' do
        if logged_in?
            erb :"country/countries"
        else
            redirect '/login'
        end
    end
end