class User < ApplicationRecord

  # The option dependent: :destroy means that if a user is destroyed all the
  # assocated microposts are too.
  has_many :microposts, dependent: :destroy

  # to make remember_token an instance variable that can be read and written
  # by just calling as if it were a method ie .remember_token
  # This is what we have to do for variables that we need across the application,
  # eg in tests, but which we don't want to have to store in a database. Database
  # column variables get this functinonality automatically via Active record,
  # like .id or .name or .password or .remember_digest??
  # similarly activation_token is not a database column, only activation_digest

  # I added :activation_key to this to create a method. I have set it in user_params,
  # which I thought would be enough, but it got rid of some errors
  attr_accessor :remember_token, :activation_token, :reset_token, :activation_key

  # This is a callback. Generally references a private method listed lower down
  # i this file that runs before saving or creating
  before_save   :downcase_email
  before_create :create_activation_digest

  # Now using unique user names and emails
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
  has_secure_password

  # has_secure_password has a separate presence validatino that catches
  # nil passwords so don't need this again in validates below. Because we want
  # to allow empty passwords when updating them as opposed to creating them, eg
  # if updating only other user details. The user_params for writing to the database
  # requires :user, but merely permits :password and the other parameters, so if
  # the password update field is blank, it doesn't update and keeps the original
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  serialize :settings, Hash

  # Returns the hash digest of the given string.
  # defined in the User class, so the method will still be
  # available if there is no valid user object. Method is
  # mainly for testing by reproducing a password digest that
  # might be stored in the database from a given password

  # Could have used self instead of User below because the methods are
  # applying to the User object which is the object class being declared in this
  # file
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # SecureRandom generates random characters 22 long
  # it is part of Ruby standard library
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # The self makes it a class variable for User rather than a
  # local variable. new_token is not just a variable but a method defined just above
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # A manual authenticate method for remember token because there is no
  # equivalent has_secure_password function for other tokens
  # it compares a token (remember_token) with its digest stored in the database
  # The remember_token is here a variable local to the method not the instance
  # variable remember_token created by attr_accessor
  # The remember_digest attribute is the same as self.remember_digest ie using
  # as method to call up the variable from the self object, and this was created
  # automatically by Active Record from the name of the database column

  # The return false if no remember_digest (note that this variable is
  # widely accessible because it is a column in the user database) is to catch a
  # bug if have two different browsers open. If log out of one the digest is set
  # to nil, but if closed the other without logging out and relaunch, it will still
  # detect the chrome cooking but crash in Bcrypt because no digest to compare the
  # rememer token with - better to return false and then current_user is false,
  # and so invites login in the reopened browser instead.


  #def authenticated?(remember_token)
  #  return false if remember_digest.nil?
  #  BCrypt::Password.new(remember_digest).is_password?(remember_token)
  #end

   # A subsequent version of the method above works for activation_token as well as
  # remember_token, by using the :send method and making the calling method a
  # variable

  def authenticated?(attribute, token)
    # this is the User class file so methods called on the user are self, and
    # in Ruby self.send() can dispense with the self.
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    # update_attribute(:activated,    true)
    # update_attribute(:activated_at, Time.zone.now)

    # Update columns hits the database only once
    # We wouldn't make a single call to update_attributes because that method
    # uses the validations and they would fail because in this case the user has
    # no password - it was not entered when clicking the activate account in
    # the email
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email

    # Send an email to the user's entered email address
      # Deliver_now is the helper that does this
      # account_activation(@user) - or when here in the model file self - is a
      # class method declared for the UserMailer class (listed in
      # app/mailers/user_mailer) which obviously creates a
      # UserMailer object, recreates an instance variable @user for use within
      # the UserMailer class, as opposed to the UserController class, including
      # the mailer views, and performs the mail to function to the user's email
      # address, with a subject message
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    # update_attribute(:reset_digest,  User.digest(reset_token))
    # update_attribute(:reset_sent_at, Time.zone.now)
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    # The < means earlier than rather than less than
    reset_sent_at < 2.hours.ago
  end

  def feed

    # Below just shows the microposts of the user
    # Micropost.where("user_id = ?", id)

    # This shows the microposts of the user and followed users
    # To get an array of the followed users of the first user, we would need something
    # like User.first.following.map(&:id) where & is shorthand converting a method
    # in this case the id method (which rturns the user from their id) into a block
    # ie map returns the array id of all the followed users
    # In fact rails provides this by default as a method, constructed from the
    # fact that there is a has_many :following association - hence:
    # User.first.following_ids

    # We need SGL language to interrogate the database, so as well as the user
    # itself as above (user_id=?, we have "user_id IN (?)", following_ids, id
    # The ? converts the list of users into a form that SQL will understand
    # The first ? has following_ids as the inserted value and the second one has id

    # Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)

    # We can refactor the above line by replacing ? with hash keys and then
    # specifying the values:

    # Micropost.where("user_id IN (:following_ids) OR user_id = :user_id",
    #                following_ids: following_ids, user_id: id)

    # If we want to take out microposts from teh database in more conveniently sized
    # blocks we do so by selectnig subsets one after the other, and SQL can do
    # this at the database level with interpolating an SQL code into a string
    # instead of escaping with ? and specifying after the comma

    # the SQL is selecting some followed_id from those followed by the user

    #following_ids = "SELECT followed_id FROM relationships
    #                 WHERE  follower_id = :user_id"
    #Micropost.where("user_id IN (#{following_ids})
    #                 OR user_id = :user_id", user_id: id)
    Micropost.all
  end


  # Checks if wrong activation code
  #  def wrong_key
  #    if self.activation_key != "280767"
  #      return true
  #    else
  #      return false
  #    end
  #  end
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
      # could also write
      # email.downcase!
    end

    # Creates and assigns the activation token and digest.
    # We don't update the attributes because this is at first creation so the
    # activation_digest column is autmomatically entered when creating just after
    # this step by def create action in users_controller

    # As with the other methods in this file, because it is all part of defining
    # the User class, we do not run methods like new_token on a user instance,
    # either local user or instance variable @user (which will be recognised in
    # associated views and controllers for that class) but on the User class
    # itself, hence User capital letter U. So when creating an instance of the
    # User class, this method can be run on it. There may in fact be no instances
    # of user in existence yet. This is basic Ruby. So before creating a user
    # in the create action, this class method associates an activation_token
    # and activation_digest with the created user object.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
