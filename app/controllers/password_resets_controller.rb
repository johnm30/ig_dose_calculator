class PasswordResetsController < ApplicationController
  
  # Before running edit or update actions, need the user and
  #  need to check user is valid - see private definitions below
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    @user = User.find_by(name: params[:password_reset][:name])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Name not found"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    
    # If entered an empty password, add a specific error message
    # and go back to the password reset page
    if params[:user][:password].empty?                  
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    
    # If successful
    elsif @user.update_attributes(user_params)          
      log_in @user
      # This clears the reset digest so cannot use back button
      # on browser to reset again when already reset successfully
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    
    # If password was invalid ie failed to update_attributes
    # according to user_params defined below
    else
      render 'edit'                                     
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    # Get the user from their email address via params. This was
    # stored as a hidden field on the password resets form
    
    # Now need to store the name somehow
    def get_user
      @user = User.find_by(name: params[:name])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    # Checks expiration of reset token.
    def check_expiration
      
      # password_reset_expired is defined in the user model file
      # as it is an instance method
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
