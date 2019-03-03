class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action -> { flash.now[:success] = flash[:success].html_safe if flash[:html_safe] && flash[:success] }

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in to access this page."
        redirect_to login_url
      end
    end
end
