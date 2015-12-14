class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Registered!'
      log_in @user
      redirect_to root_url
    else
      flash.now[:danger] = 'Something is wrong with your form'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    initialize_events
  end

  def profile
    @user = current_user
    initialize_events
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def initialize_events
    @attended_events = @user.attended_events.paginate(page: params[:page],
                                                      per_page: 3)
    @created_events = @user.created_events.paginate(page: params[:page],
                                                    per_page: 3)
  end
end
