class WelcomeController < ApplicationController
    def index
        @posts = Post.where(:created_at =>(Date.today - 35.days)..Date.today).order('views desc').limit(3)
        @collabs = Collab.order("created_at DESC").limit(3)
    end 
end
