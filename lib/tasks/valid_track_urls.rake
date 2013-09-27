require 'pp'
require "net/http"

namespace :valid_track_urls do 
  desc "check that the permalink for each track in the tracks database is still valid" 

  task :test_tracks => :environment do 
    puts "You are checking to see that database tracks' urls are still valid"

    TrackData.all.each do |track|
      url = URI.parse("http://soundcloud.com/#{track.user_permalink}/#{track.track_permalink}")
      req = Net::HTTP.new(url.host, url.port)
      res = req.request_head(url.path)
      puts(url) if res.code != "200"
    end 

  end 
    
end   
