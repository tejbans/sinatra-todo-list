class TasksController < ApplicationController

    get "/tasks" do
      redirect_if_not_logged_in
      @lists = current_user.lists
      erb :'tasks/index'
    end

    get "/tasks/new" do
      redirect_if_not_logged_in
      erb :'tasks/new'
    end

    get "/tasks/:id/edit" do
      redirect_if_not_logged_in
      @task = Task.find(params[:id])
      if @task.list.user.username == current_user.username
      erb :'tasks/edit'
      else
        session[:notice] = "You can only see/edit your own tasks"
        redirect "/login"
      end
    end

    post "/tasks/:id" do
      redirect_if_not_logged_in
      @task = Task.find(params[:id])
      unless Task.valid_params?(params)
        session[:notice] = "Invalid Entry"
        redirect "/tasks/#{@task.id}/edit"
      end
      @task.update(description: params[:description], priority: params[:priority], completed: params[:completed], list_id: params[:list_id])
      redirect "/tasks/#{@task.id}"
    end

    get "/tasks/:id" do
      redirect_if_not_logged_in
      @task = Task.find(params[:id])
      if @task.list.user.username == current_user.username
      erb :'tasks/show'
      else
        session[:notice] = "You can only see/edit your own tasks"
        redirect "/login"
      end
    end

    post "/tasks" do
      redirect_if_not_logged_in
      unless Task.valid_params?(params)
        session[:notice] = "Invalid Entry"
        redirect "/tasks/new"
      end
      Task.create(params)
      redirect "/tasks"
    end

    delete '/tasks/:id/delete' do
    task = Task.find(params[:id])
    if task.list.user.username == current_user.username
     task.destroy
     redirect to '/tasks'
    end
  end
  end