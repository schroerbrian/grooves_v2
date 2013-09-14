class TrackData < ActiveRecord::Base
  attr_accessible :track_id, :track_name, :track_permalink, :user_id, :username,
  :user_city, :user_country, :user_permalink, :user_avatar_url, :lat, :lng
end
