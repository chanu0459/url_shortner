class UrlShortner < ActiveRecord::Base
  attr_accessible :clicks, :unique_code, :url, :expires_at
end
