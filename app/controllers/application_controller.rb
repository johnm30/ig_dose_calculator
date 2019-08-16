class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # This is why the methods in sessions helper, eg current_user are available to
  # all controllers
  include SessionsHelper


  before_action -> { flash.now[:success] = flash[:success].html_safe if flash[:html_safe] && flash[:success] }


  private

    def create_commissionings

      commissionings = ["Prior panel approval not required", "Prior panel approval not required (emergency list)", "Prior panel approval required", "Prior panel approval required (left-hand grey)", "Requires IFR (right-hand grey)", "Shown to be ineffective (black)", "Unlisted"]

    end

    def create_priorities

      priorities = ["1. Red", "2. Blue", "3. Grey", "Black", "Unlisted"]

    end

    def create_specialities

      specialities = ["Immunology", "Haematology", "Neurology", "Infectious Diseases", "Other"]

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
