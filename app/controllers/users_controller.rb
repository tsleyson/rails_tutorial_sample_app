class UsersController < ApplicationController
  # before_actions are methods run before any invocation of a method
  # in the only list.
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    unless signed_in? 
      @user = User.new(user_params)
      # Rails 4. Rails 3 needs the strong_parameters gem to do this.
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new' # Reloads signup page with error messages.
      end
    else
      redirect_to root_url, notice: "Already signed in."
    end
  end
    

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

  def user_params
    # Use strong params. Does not allow setting admin attribute
    # through a web URL (since admin is not under permit).
    # params is a method of the base class AppController.
    # Returns a new params object. 
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  # Before filters

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
