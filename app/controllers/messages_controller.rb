class MessagesController < ApplicationController
  filter_access_to :create
  filter_access_to :read, attribute_check: true
  before_filter :load_user, :only => [:create, :read]

  def create
    @message = Message.new params.require(:message).permit(:text)
    @message.sender = current_user
    @message.recipient = @user
    if @message.save
      PrivatePub.publish_to "/dialogs/#{@user.id}/#{current_user.id}", action: 'create', message: @message
      render :json => @message
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end

  def read
    @message.update_attribute :read, true
    PrivatePub.publish_to "/dialogs/#{@user.id}/#{current_user.id}", action: 'read', message: @message
    render :nothing => true
  end

  private

    def load_user
      @user = User.where.not(id: current_user.id).find params[:dialog_id]
    end
end
