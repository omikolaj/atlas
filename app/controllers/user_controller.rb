class UserController  < ApplicationController

    get '/dashboards/:slug' do
        if logged_in?
            @user = current_user
            erb :"user/profile"
        else
            redirect '/'
        end
    end

    get '/dashboards/:slug/edit' do
        if logged_in?
            @user = current_user
            erb :'user/edit'
        else
            redirect '/'
        end
    end

    patch '/dashboards/:slug' do
        if logged_in?
            @user = current_user
            if @user.update(:username => params["username"], :email => params["email"], :password => params["password"])
                redirect "/dashboards/#{@user.slug}"
            else
                flash[:danger] = "Something went wrong..."
                redirect "/dashboards/#{@user.slug}/edit"
            end
        else
            redirect '/'
        end
    end

    get '/logout' do
        logout!
        redirect "/"
    end

    post '/dashboards/:user_slug/:country_id' do
        if logged_in?
            @user = User.find_by_slug(params["user_slug"])
            begin 
                @user.countries << Country.find_by_id(params["country_id"])
                redirect "/dashboards/#{@user.slug}"
            rescue
                flash[:info] = "<strong>Info:</strong> You already have this country added!"
                redirect "/countries/#{@user.countries.find_by_id(params["country_id"]).slug}#add_fav"
            end
        else
            redirect "/"
        end
    end

    delete '/dashboards/:user_slug/remove/:country_name' do
        if logged_in?
            @user = current_user
            if @country = @user.countries.find_by(:name => params["country_name"])
                @user.countries.delete(@user.countries.find_by(:name => params["country_name"]))
                redirect "/dashboards/#{@user.slug}"
            end
        else
            redirect '/'
        end
    end
end