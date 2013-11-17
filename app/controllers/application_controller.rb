class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_current_user

  private

    def set_current_user
      Authorization.current_user = current_user
    end

    def permission_denied
      respond_to do |format|
        format.html { redirect_to current_user ? root_url : new_user_session_url, status: :unauthorized }
        format.js   { head :unauthorized }
      end
    end
end
