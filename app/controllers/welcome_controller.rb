class WelcomeController < ApplicationController

  def index
    @urls = Url.order(click_count: :desc)
    @url = Url.new
  end

end
