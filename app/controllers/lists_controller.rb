class ListsController < ApplicationController

    get '/lists' do
      redirect_if_not_logged_in
      erb :'lists/index'
    end

    get '/lists/new' do
      redirect_if_not_logged_in
      erb :'lists/new'
    end

  get "/lists/:id/edit" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    if @list.user.username == current_user.username
     erb :'lists/edit'
    else
      session[:notice] = "You can only see/edit your own lists"
      redirect "/login"
    end
  end

  post "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    unless List.valid_params?(params)
      session[:notice] = "Invalid Entry"
      redirect "/lists/#{@list.id}"
    end
    @list.update(name: params[:name])
    redirect "/lists/#{@list.id}"
  end


  get "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    if @list.user.username == current_user.username
    erb :'lists/show'
    else
      session[:notice] = "You can only see/edit your own lists"
      redirect "/login"
    end
  end

  post "/lists" do
    redirect_if_not_logged_in
    unless List.valid_params?(params)
      session[:notice] = "Invalid List Name"
      redirect "/lists/new"
    end
    List.create(name: params[:name], user_id: current_user.id )
    redirect "/lists"
  end

  delete '/lists/:id/delete' do
    list = List.find(params[:id])
    if list.user.username == current_user.username
     list.destroy
     redirect to '/lists'
    end
  end


end