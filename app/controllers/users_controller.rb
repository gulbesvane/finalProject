class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]


    # display single user's profile page
    def show
      # get set nr of posts associated with the user to display on a single page
      @posts = @user.posts.order("created_at DESC").paginate(page: params[:page], per_page: 2)
    end

    # new user signup form
    def new
      @user = User.new
    end

    # edit user's profile
    def edit
    end

    def update
      if @user.update(user_params)
        flash[:notice] = "Your account has been updated."
        redirect_to @user
      else
        render 'edit'
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        # log in user once they have signed in
        session[:user_id] = @user.id
        flash[:notice] = "Welcome, #{@user.username}! You have successfully created your account!"
        redirect_to @user
      else
        render 'new' , status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      # end the current session by setting session id to nil if the current user is deleting own account
      session[:user_id] = nil if @user == current_user
      flash[:notice] = "Account and all your posts have been deleted."
      redirect_to root_path, status: :see_other
    end

    private
    def user_params
      params.require(:user).permit(:username, :email, :password, :image)
    end

    def set_user
      # find user with the specific id
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own account"
        redirect_to @user
      end
    end

end
