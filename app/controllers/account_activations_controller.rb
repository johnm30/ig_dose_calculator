class AccountActivationsController < ApplicationController

  # The user clicking the link to GET edit for account activation triggers
  # this edit action, which gets the name (in my version rather than email) from
  # params (which was passed with the
  # clicking), finds the database user based on that name, checks there is
  # such a user, and that the user is not already activated and then authenticates
  # with the params id which in this case is the account activation token - this
  # checking the digest of the token with the already stored digest
  
  # Now finding by name
  def edit
    user = User.find_by(name: params[:name])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      
      # Activate is a method moved to the user model file
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end

