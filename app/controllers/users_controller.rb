class UsersController < ApplicationController

  def ride
    @ride = Ride.create(user_id: current_user.id, attraction_id: params[:attraction_id].to_i)
    @attraction = Attraction.find(params[:attraction_id].to_i)
    # binding.pry
    if @ride.take_ride == true
      flash[:notice] = "Thanks for riding the #{@attraction.name}!"
      redirect_to user_path(current_user)
    else
      flash[:alert] = @ride.take_ride
      redirect_to user_path(current_user)
    end
  end

  def index
    @users = User.all
  end

  def show
    if !current_user
      redirect_to root_path
    else
      @user = User.find(params[:id])
      if params[:attraction_id]
        @attraction = Attraction.find(params[:attraction_id].to_i)
        flash[:notice] = "Thanks for riding the #{@attraction.name}!"
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Signup didn't work"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:message] = "Editing didn't work"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :ride_id, :attraction_id, :mood, :happiness, :nausea, :tickets, :height, :admin)
    end
end
