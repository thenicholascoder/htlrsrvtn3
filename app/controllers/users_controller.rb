class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  include SessionsHelper

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # debugger
    # puts params.to_yaml
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # reset_session
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      if current_user.is_admin
        redirect_to retrieve_last_page_or_default(default_path: root_path)
      else
        redirect_to @user
      end
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.is_admin
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to retrieve_last_page_or_default(default_path: root_path)
    else
      User.find(params[:id]).destroy
      flash[:success] = "You have successfully deleted your account"
      redirect_to users_url, status: :see_other
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country, :email, :mobile, :is_admin, :password, :password_confirmation)
  end

  # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless current_user?(@user) or current_user.is_admin?
  end
end
