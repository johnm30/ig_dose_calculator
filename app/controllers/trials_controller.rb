class TrialsController < ApplicationController
  # Can only see the My Book Reviews if logged in anyway
  before_action :logged_in_user, only: [:show, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @trials = current_user.trials
    render 'show'
  end

  def destroy
    # This was tricky! For micropost, just seem to put micropost as the path, and
    # it seems to identify the micropost instance variable automatically in
    # microposts controller, possibly because of resources :microposts in routes.
    # But doesn't work for book reviews, perhaps because I haven't followed the
    # naming format.
    # I cannot just copy system for count_abacus delete, because this is removing
    # the whole model-less resource when quitting, not a model instance
    # So I set route to /book reviews and in the html set the link to book_reviews_path
    # with a parameter of the book_review id in question (not the book_review object).
    # This sends a query parameter on the url which is the id, but it is called
    # format not id so I call params[:format]
    @trial = Trial.find(params[:format])
    @trial.destroy
    flash[:success] = "Trial deleted"
    redirect_to request.referrer || trials_url
  end





  private

    def correct_user
      @btrial = current_user.trials.find_by(id: params[:id])
      if @trial.nil? && !current_user.admin?
        redirect_to trials_url
      end
    end
end
