class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:name_login])
    if @user
      session[:user_id] = @user.id
      session[:name] = @user.name

      redirect_to(root_path)
    end
  end

  def log_in
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil

    redirect_to root_path
  end
end
