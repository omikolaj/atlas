class UserController  < ApplicationController


    get '/profiles/:slug' do
        binding.pry
        if logged_in?
            @user = current_user
            erb :"user/profile"
        else
            redirect '/login'
        end
    end

    get '/logout' do
        binding.pry
        logout!
        redirect "/login"
    end
end