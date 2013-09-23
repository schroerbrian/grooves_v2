class TracksController < ApplicationController

  def home
    t = Track.new 
    @filtered_tracks = t.get_tracks_from_soundcloud
  end

  def test
  end

  #ajax call; used in test.html.erb script 
  def get_database_tracks
  	most_recent_database_tracks = TrackData.last(8)
  	render :json => most_recent_database_tracks
  end

  #test controllers are below
  def track
	end

end
