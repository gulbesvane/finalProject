class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  # call require_login before all actions except index and show
  before_action :require_login, except: [ :index, :show ]
  # call require_same_user to check that the logged in user is also the author of the post
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
    # force all tags to be saved lowercase
    ActsAsTaggableOn.force_lowercase = true
    # remove all unused tag objects
    ActsAsTaggableOn.remove_unused_tags = true
    @tags = ActsAsTaggableOn::Tag.most_used(10).order("taggings_count DESC")
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 2)
    else
      #potentially change to views DESC if want to show by popularity, use will_paginate gem
      @posts = Post.order("created_at DESC").paginate(page: params[:page], per_page: 2)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    # incrments view by 1 when more button is pressed
    @post.views = @post.views + 1
    @post.save
    @comments = @post.comments.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    # assign current_user 
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    flash[:notice] = "Your posts has been deleted."
    redirect_to posts_path, status: :see_other
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :link, :views, :tag_list, :image)
    end

    def require_same_user
      # if current user is not the author of the post and is not admin, then redirect
      if current_user != @post.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own project post."
        redirect_to @post
      end
    end
end
