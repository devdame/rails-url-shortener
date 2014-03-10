
class UrlsController < ApplicationController

  def short_url
    @url = Url.where('shortened_url =?', params[:short_url])[0]
    @url.click_count += 1
    @url.save
    redirect_to(@url.url)
  end

  def create
    # raise params.inspect
    @url = Url.new(url_params)
    if @url.save
      flash[:notice] = "You did it, dude!  Your shortened url is #{@url.shortened_url}"
    else
      flash[:notice] = "Naw, dude, naw.  You have to put in a real website, okay?"
    end
    redirect_to '/'
  end

  private

  def url_params
    x = params.require(:url).permit(:url)
    x[:user_id] = params[:user_id]
    x
  end

end
