class CommentsController < ApplicationController
    before_action :require_login
    before_action :set_post

    def create
        @comment = @post.comments.create(comment_params)
        @comment.user = current_user

        if @comment.save
          flash[:notice] = 'Comment has been added'
          redirect_to post_path(@post)
        else
          flash[:alert] = 'Unable to add comment'
          redirect_to post_path(@post)
        end
    end

    def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to post_path(@post)
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :parent_id)
    end
end

