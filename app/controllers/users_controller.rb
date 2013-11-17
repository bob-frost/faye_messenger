class UsersController < ApplicationController
  filter_access_to :all

  def index
    @users = User.where.not(id: current_user.id).order :username
  end

end
