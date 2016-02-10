
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :profile_owner, only: [:edit, :update]


  def show
    @activities = PublicActivity::Activity.where(owner: current_user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @properties = Property.where(owner_id: current_user.id)
    @lists = List.where(owner_id: current_user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name, :user_name, :bio, :location)
  end

  def profile_owner
    redirect_to current_user, notice: 'Not Authorized' unless @user == current_user
  end


end
