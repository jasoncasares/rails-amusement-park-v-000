class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_name(params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Sign in was successful"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Sign in was unsuccessful"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end

end
