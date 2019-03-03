class UsersController < ApplicationController


  # Ensures that have to be logged in to use the edit or update actions
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  # Ensures that have to be logged in as the same user to use edit or update
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  before_action :check_prize_before_show,    only: :show

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

    if user_params[:activation_key] != ACTIVATION_KEY
      flash.now[:danger] = "Wrong activation key."
      render 'new'
    else
      if @user.save
        # Send_activation_email is a method moved to the user model file because
        # it deals with manipulating the user object
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
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

  # Calls action following, to lead to show following page, and set the list
  # on that page. Note that the page is the same for followers, just a
  # different list to populate it. Rails is expecting a following.html.erb view
  # because of the name of the action, so specify the actual view by render
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  # Because it is the show users page that has the link to prizes, control for
  # this goes here rather than in a separate recipients controller. The latter
  # will just have create and destroy

  def awarded_prizes
    @user  = User.find(params[:id])
    @awarded_prizes = @user.awarded_prizes.paginate(page: params[:page])
    @title = "#{@user.name}'s Awarded Prizes (#{ @awarded_prizes.count})"
    render 'show_awarded_prizes'
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

    # Checks if due a prize before rendering page
    def check_prize_before_show
      # finds the user that we are looking up from the id on the web page
      @user = User.find(params[:id])
      # Only check for prizes if current user is looking at their own stats
      if @user==current_user
      abacus_score = current_user.abacus_score
      if abacus_score==nil
        abacus_score = 0
      end
      tables_score = current_user.tables_score
      if tables_score==nil
        tables_score = 0
      end
      followers_score = current_user.followers.count
      if followers_score==nil
        followers_score = 0
      end
      book_reviews_score = current_user.book_reviews.count
      if book_reviews_score==nil
        book_reviews_score = 0
      end

      created_prizes_score = Prize.where(user_id: current_user.id).count
      if created_prizes_score==nil
        created_prizes_score = 0
      end
      returned_prizes = current_user.returned_prizes
      if returned_prizes==nil
        returned_prizes = 0
      end
      general_knowledge_questions_score = current_user.general_knowledges.count
      if general_knowledge_questions_score==nil
        general_knowledge_questions_score = 0
      end
      general_knowledge_score = current_user.general_knowledge_score
      if general_knowledge_score==nil
        general_knowledge_score = 0
      end
      stuff_stat = abacus_score + tables_score + followers_score + book_reviews_score + general_knowledge_score + created_prizes_score + general_knowledge_questions_score
      if stuff_stat <=50
        new_prizes = stuff_stat / 10 - current_user.awarded_prizes.count - returned_prizes
      else
        new_prizes = 4 + stuff_stat / 50 - current_user.awarded_prizes.count - returned_prizes
      end

      # flash[:success] = "New prizes: #{stuff_stat.div 10} - #{current_user.awarded_prizes.count} = #{new_prizes}"
      if new_prizes > 0
        prize_count=Prize.count
        message = ""
        new_prizes.times do
          count=0
          loop do
            # PostgreSQL syntax
            # MySQL syntax is RAND not RANDOM, but the development environment is sqlite, which is RANDOM
            # At the moment random seems to select the last one entered in seed, which seems to be labelled
            # first from id point of view, they get added from seed by new one being sent to the top slot id = 1.
            # This is because the default ordering is by created at time and in descending order
            # so it is just ignoring the random bit and doing first. What about in production??
=begin
 case ActiveRecord::Base.connection.adapter_name
    when 'MySQL'
      'rand()'
    when 'SQLite'
      'random()'
    end
=end
            # i installed a gem randumb which does the syntax for different databases
            # but it doesn't work. The method order_by_rand is not recognised
            # Artist.order_by_rand.first
            # a random Artist if there are any, otherwise nil
            # Artist.order_by_rand.limit(3).all
            # an array of three Artists picked at random
            # Artist.order_by_rand.limit(1).all
            # an array containing one random Artist
            # Artist.order_by_rand_weighted(:score).first
            # a random Artist but weighted by :score with higher score artists more likely by score * random probability

            # If calling the method on the same database or scope multiple times,
            # there is a cache by default in ActiveRecord, so that the same result
            # will come up repeatedly. Below stops this:
            # Artist.uncached { Artist.order_by_rand.first }
            # chosen_prize = Prize.uncached {Prize.order_by_rand.first}


            # chosen_prize = Prize.uncached {Prize.order("RANDOM()").first}

            # With the offset method which skips a number of rows before starting
            # to return rows, this wouldn't work if skipping by id, because if delete
            # many rows, the count goes down but the maximum id stays the same; but
            # i think default ordering is by descending created at time. So will skip zero
            # to prize_count-1, which is what we want.
            chosen_prize = Prize.offset(rand(prize_count)).first
            if !current_user.awarded?(chosen_prize) && chosen_prize !=nil
              current_user.award(chosen_prize)
              message = message + "Congratulations! You have won #{chosen_prize.content.sub(/^./, &:downcase)}!"
              if new_prizes > 1
                message = message + "<br>"
              end
              break
            end
            if count >=20
              message = message + "Congratulations! But you have already won all the available prizes."
              if new_prizes > 1
                message = message + "<br>"
              end
              break
            end
            count+=1
          end
        end
        flash[:success] = message
        # This makes the flash understand the <br> as html not text
        # see the application_controller.rb file
        # Should use sparing as do not want to introduce any user data in flash
        # as then vulnerable to hackers
        flash[:html_safe] = true

        # Problem is that if do flash, it appears on the show page as that is the
        # one about to be rendered, and then on the next page as well, and only
        # on the next page does it do the html safe.

        # If do flash.new not to render on the next page the html safe doesn't
        # render at all

        # So try and change to a redirect immediately after the flash
        # Now it renders wrong and then at the end of page load it renders right?!
        redirect_to @user
      end
      end
    end



end
