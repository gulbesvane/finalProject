class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        # see if a user exists in the database by checking the email entry
        if user && user.authenticate(params[:session][:password])
          # assign user id to the sessions object, this will allow to keep the user logged in until destroy (log out) method is called.
          session[:user_id] = user.id
          flash[:notice] = "Logged in successfully."
          redirect_to user
        else
          flash.now[:alert] = "Login details are incorrect."
          render 'new' , status: :unprocessable_entity
        end
    end

    def destroy
      # log out the user
      session[:user_id] = nil
      flash[:notice] = "You have been logged out!"
      redirect_to root_path
    end
end