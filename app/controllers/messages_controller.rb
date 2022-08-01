class MessagesController < ApplicationController
    before_action :require_login
    before_action :set_collab

    def create
        @message = @collab.messages.create(message_params)
        @message.user = current_user

        if @message.save
          flash[:notice] = 'Message has been added'
          redirect_to collab_path(@collab)
        else
          flash[:alert] = 'Unable to add message'
          redirect_to collab_path(@collab)
        end
    end

    def destroy
      @message = @collab.messages.find(params[:id])
      @message.destroy
      redirect_to collab_path(@collab)
    end

    private

    def set_collab
      @collab = Collab.find(params[:collab_id])
    end

    def message_params
      params.require(:message).permit(:content, :parent_id)
    end
end
