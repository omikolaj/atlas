class UserController  < ApplicationController


    get '/dashboards/:slug' do
        binding.pry
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



    post '/dashboards/:user_slug/:country_id' do
        if logged_in?
            @user = User.find_by_slug(params["user_slug"])
            binding.pry
            @user.add_country_to_dashboard(params["country_id"])
            redirect "/dashboards/#{@user.slug}"
        else
            redirect "/login"
        end
    end
end