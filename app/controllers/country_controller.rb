class CountryController < ApplicationController

    get '/countries' do
        if logged_in?
            @flags ||= Country.load
            binding.pry
            erb :"country/countries"
        else
            redirect '/'
        end
    end

    get '/countries/:country' do
        if logged_in?
            @country = Country.find_by_slug(params["country"])
            @current_user = current_user
            erb :"country/show"
        else
            redirect '/'
        end
    end

end