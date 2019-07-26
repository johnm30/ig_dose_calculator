class UsersController < ApplicationController


  # Ensures that have to be logged in to use the edit or update actions
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  # Ensures that have to be logged in as the same user to use edit or update
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
    # @users = User.paginate(page: params[:page])

    # use the where method to paginate (ie list) only users that are activated
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # redirect if the user was not activated
    # and is like && but has lower precedence so that here root_url belongs to
    # redirect_to as it should rather than to return
    redirect_to root_url and return unless @user.activated
  end

  def new
    @user = User.new
  end

  def create
    # Though I don't need @user to do the test for activation key, the test for
    # render new will fail because there are no parameters set on user I think
    # <resource>_params is strong params. The params are got in this case from a
    # form but using them directly by params[:user][:activation_key] is open to
    # hacking. Strong params declares user_params below in a private method
    # and is read only
    @user = User.new(user_params)
    # The constant ACTIVATION_KEY is set in config/environments/production.rb from
    # the Heroku ENV['ACTIVATION_KEY'] which is set in the console by
    # heroku config:add ACTIVATION_KEY = 123456, and can be verified later by
    # heroku config (and then blank)

    if !Rails.env.development?
      if user_params[:activation_key] != ACTIVATION_KEY
        flash.now[:danger] = "Wrong activation key."
        # Added this flag so that will trigger the new form rather than the
        # change form even when there is a user name already set.
        @failed_signup = true
        render 'new'
      else
        if @user.save
          # Send_activation_email is a method moved to the user model file because
          # it deals with manipulating the user object
          @user.send_activation_email
          flash[:info] = "Please check your email to activate your account."
          redirect_to root_url
        else
          @failed_signup = true
          render 'new'
        end
      end
    else
      if @user.save
        # Send_activation_email is a method moved to the user model file because
        # it deals with manipulating the user object
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
        @failed_signup = true
        render 'new'
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :activation_key)
    end


    # Confirms the correct user.
    # Again current_user returns the current user so have to be logged in as that user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end




end
