
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/lists'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], email: params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/lists'
    end
  end


  get '/login' do 
    
    if !logged_in?
      erb :'users/login'
    else
      redirect '/lists'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/lists"
    else
      session[:notice] = "Username or password Incorrect: try again"
      redirect to '/login'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end