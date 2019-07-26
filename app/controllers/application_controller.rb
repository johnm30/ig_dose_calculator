class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # This is why the methods in sessions helper, eg current_user are available to
  # all controllers
  include SessionsHelper


  before_action -> { flash.now[:success] = flash[:success].html_safe if flash[:html_safe] && flash[:success] }


  private

    def create_categories

      @categories = ["No prior panel approval", "Emergency list", "Prior panel approval", "Left hand grey", "Right hand grey", "Black"]

    end

    def get_expand_descriptions
      if session[:expand_description] == nil
        expand_description ||= Hash.new(0) # the 0 means this is default value when key is not yet set
        session[:expand_description] = expand_description
      else
        expand_description = session[:expand_description]
      end
      return expand_description
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
