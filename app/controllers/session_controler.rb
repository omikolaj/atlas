class SessionController < ApplicationController
    
    get '/signup' do
      if logged_in?
        redirect '/countries'
      else
        erb :"session/signup", :layout => :sessionlayout
      end
    end

    post '/signup' do
        @user = User.new(:username => params["username"], :password => params["password"], :email => params["email"])
        if @user.save
            login(@user.email)
            redirect "/countries"
        else
            flash[:danger] = "Something went wrong..."
            redirect '/signup'
        end
    end

    post '/' do
        @user = User.find_by(:username => params["username"].downcase)
        if @user && @user.authenticate(params["password"])
            login(@user.email)
            redirect to '/countries'
        else
            flash[:danger] = "Incorrect information"
            redirect '/'
        end
    end

    get '/' do
        if logged_in?
            redirect '/countries'
        else
            erb :"session/welcome", :layout => :sessionlayout
        end
    end
end