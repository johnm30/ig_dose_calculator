class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action -> { flash.now[:success] = flash[:success].html_safe if flash[:html_safe] && flash[:success] }


end
