class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

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

    private
    def user_params
      params.require(:user).permit(:username, :email, :password, :image)
    end

    def set_user
      # find user with the specific id
      @user = User.find(params[:id])
    end

end
