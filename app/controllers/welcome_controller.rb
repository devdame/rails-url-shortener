class WelcomeController < ApplicationController

  def index
    @urls = Url.order(click_count: :desc)
    @url = Url.new
    # CODE REVIEW: begging for a current_user helper
    @user = User.where(id: session[:user_id]).first
  end

end
