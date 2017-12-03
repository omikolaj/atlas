class UserController  < ApplicationController


    get '/profiles/:slug' do
        if logged_in?
            @user = current_user
            erb :"user/profile"
        else
            redirect '/login'
        end
    end

    get '/logout' do
        logout!
        redirect "/login"
    end
end