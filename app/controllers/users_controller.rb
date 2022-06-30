class UsersController < ApplicationController

    def show
      # find user with the specific id
      @user = User.find(params[:id])
      # get all posts associated with the user
      @posts = @user.posts
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "Your account has been updated."
        redirect_to posts_path
      else
        render 'edit'
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "Welcome, #{@user.username}! You have successfully created your account!"
        redirect_to root_path
      else
        render 'new'
      end
    end

    private
    def user_params
      params.require(:user).permit(:username, :email, :password, :image)
    end

end
