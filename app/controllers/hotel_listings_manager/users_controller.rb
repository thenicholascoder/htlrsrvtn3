class HotelListingsManager::UsersController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def index
    store_last_page
    # @users = User.all
    @users = User.paginate(page: params[:page]).per_page(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :country, :email, :mobile, :is_admin, :password, :password_confirmation)
    end
end
