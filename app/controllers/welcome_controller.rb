class WelcomeController < ApplicationController

  def index
    @urls = Url.order(click_count: :desc)
    @url = Url.new
    @user = User.where(id: session[:user_id]).first
  end

end
