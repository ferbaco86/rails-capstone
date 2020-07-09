class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save

      session[:user_id] = @user.id
      session[:name] = @user.name
      redirect_to root_path, notice: "#{session[:name]} you were succesfully created"
      #notice: "#{session[:name]} you were succesfully created" 
    else
      render :new
    end

  end

  def show
    @user = obtain_user
  end

  def edit
    @user = obtain_user
  end

  def update
    @user = obtain_user
    @user.update(user_params)

    redirect_to(root_path)
  end

  def destroy
    @user = obtain_user
    @user.destroy
    session.delete(:user_id)
    session.delete(:username)

    redirect_to root_path, alert: "User eliminated!"
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end

  def obtain_user
    User.find(params[:id])
  end
end
