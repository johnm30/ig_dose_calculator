class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Comment created!"
      redirect_to root_url
    else
      # Create a empty feed_items aray if failed so doesn't update the feeds in the home
      # page if a failed micropost attempt - note that the _feed partial only
      # works if @feed_items.any?
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Comment deleted"

    # request.referrer redirects to the previous page if valid - could be home page of user
    # profile page, or default to home page, a bit like request.original_url for
    # friendly forwarding. An alternative is to use in Rails 5
    # redirect_back(fallback_location: root_url)
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
