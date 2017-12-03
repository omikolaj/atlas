class CountryController < ApplicationController


    get '/countries' do
        binding.pry
        if logged_in?
            erb :"country/countries"
        else
            redirect '/login'
        end
    end
end