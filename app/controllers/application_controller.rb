require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secert, "Jestem_Bogiem"
  end

  get "/" do
    erb :welcome, :layout => :sessionlayout
  end

  helpers do

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def login(email)
      binding.pry
      if user = User.find_by(:email => email)
        session[:user_id] = user.id
      else
        redirect '/login'
      end
    end
  end

end
