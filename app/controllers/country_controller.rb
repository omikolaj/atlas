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
            binding.pry
            @country = Country.find_or_create_from_api(params["country"])
            @current_user = current_user
            erb :"country/show"
        else
            redirect '/login'
        end
    end

end