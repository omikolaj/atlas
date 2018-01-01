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
            erb :'user/edit'
        else
            redirect '/'
        end
    end

    patch '/dashboards/:slug' do
        if logged_in?
            if current_user.update(:username => params["username"], :email => params["email"], :password => params["password"])
                redirect "/dashboards/#{current_user.slug}"
            else
                flash[:danger] = "Something went wrong..."
                redirect "/dashboards/#{current_user.slug}/edit"
            end
        else
            redirect '/'
        end
    end

    post '/dashboards/:user_slug/:country_id' do
        if logged_in?
            if @country = Country.find_by_id(params["country_id"])
                if !current_user.countries.include?(@country)
                    current_user.countries << @country
                    redirect "/dashboards/#{current_user.slug}"
                else 
                    flash[:info] = "<strong>Info:</strong> You already have this country added!"
                    redirect "/countries/#{current_user.countries.find_by_id(params["country_id"]).slug}#add_fav"
                end
            else 
                flash[:info] = "<strong>Info:</strong> Can't find country you selected!"
                redirect "/countries"
            end
        else
            redirect "/"
        end
    end

    delete '/dashboards/:user_slug/remove/:country_name' do
        if logged_in?
            if @country = current_user.countries.find_by(:name => params["country_name"])
                current_user.countries.delete(current_user.countries.find_by(:name => params["country_name"]))
                redirect "/dashboards/#{current_user.slug}"
            else
                flash[:info] = "You no longer have this country in your favorites"
                redirect "/dashboards/#{current_user.slug}"
            end
        else
            redirect '/'
        end
    end
end