class SessionsController < ApplicationController

  def new
  end

  def create
    # Using an instance variable @user rather than local variable user so that the
    # user can be accessed across the application for example in tests. When we can
    # access the user we can also access the user's parameters eg remember_token

    # The authenticate method is provided automatically by has_secure_password helper

    # Using find by name not email now
    logger.debug "Users = #{User.all}"
    @user = User.find_by(name: params[:session][:name])
    #logger.debug "User Name = #{@user.name}"
    if @user && @user.authenticate(params[:session][:password])
      # Log the userrail in, remember the user, and redirect to the user's show page
      # Note that the remember function is a wrapper function declared
      # in the sessions helper file (like the other methods here) and not the same
      # as the remember function declared as a user class method in user.rb. The
      # latter remember function stores just the remember_token hash
      # in the database

      # Log in if user is activated - activated is a bolean column in the data model
      if @user.activated?
        #the params function calls the value of the remember_me checkbox on the form
        # then uses the ternary operator:
        #     true/false expresson ? action if true : action if false
        log_in @user

        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)

        # Redirects to the stored url if logging in after a failed attempt at editing,
        # otherwise defaulting to redirecting to @user (which is shorthand for
        # user_url(@user))
        redirect_back_or @user
      else
        message  = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # Create an error message.
      # use flash.now rather than flash because flash renders until after opening
      # a new page, not if re-renderig the same page, while flash.now will render
      # until any request
      flash.now[:danger] = 'Invalid name/password combination'
      render 'new'
    end
  end

  def destroy
    # The if logged_in? catches a bug where if the user had two browser windows
    # open and logged out of one, the other window would still have the logout
    # invitation and crash if clicked because there would be no current_user to forget
    log_out if logged_in?
    redirect_to root_url
  end
end
