class DialogsController < ApplicationController
  filter_access_to :all
  before_filter :load_user, only: [:show, :read]

  def index
    @users = current_user.collocutors.order :username
  end

  def show
    @messages = Message.dialog current_user, @user
  end

  def read
    scope = Message.where(recipient_id: current_user.id, read: false).where('id <= ?', params[:until_id])
    if scope.exists?
      scope.update_all read: true
      PrivatePub.publish_to "/dialogs/#{@user.id}/#{current_user.id}", action: 'readUntil', id: params[:until_id].to_i
    end
    render nothing: true
  end

  private

    def load_user
      @user = User.where.not(id: current_user.id).find params[:id]
    end

end
