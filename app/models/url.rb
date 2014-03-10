class Url < ActiveRecord::Base
  belongs_to :user
  before_create :shorten_url
  validate :validate_url

  def shorten_url
    self.shortened_url = rand(99).to_s.concat(('a'..'z').to_a.sample).concat(('a'..'z').to_a.sample).concat(rand(99).to_s).concat(('a'..'z').to_a.sample)
  end

  def to_url
    "http://oursite.#{shortened_url}"
  end

  def listify
    "#{to_url}   (#{url}) - Clicks: #{self.click_count}"
  end

  def validate_url
    if self.url == "" || ! self.url.match(/.+\.\w{2,}/)
      return errors.add(:url, "This is not a valid web address!")
    end
    unless self.url.match(/\Ahttps?:\/\//)
      self.url = "http://".concat(self.url)
    end
    begin
      parsed_uri = URI(self.url)
      rescue
      return errors.add(:url, "This is not a valid web address!")
    end
    response = Net::HTTP.get_response(parsed_uri)
    unless 200 <= response.code.to_i && response.code.to_i < 400 && response.code.to_i != 303
      return errors.add(:url, "This is not a valid web address!")
    end
  end
end
