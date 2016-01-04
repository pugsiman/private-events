class UsersController < ApplicationController
  before_action :logged_in_user, only: [:profile, :show]

  def new
    redirect_to root_url if logged_in?
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
    params[:id] ? @user = User.find(params[:id]) : @user = current_user
    @attended_events = @user.attended_events.paginate(page: params[:page],
                                                      per_page: 8)
    @created_events = @user.created_events.paginate(page: params[:page],
                                                    per_page: 8)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
