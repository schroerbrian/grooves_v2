class TracksController < ApplicationController

  def test
  	@last_tracks = TrackData.last(10)
  	@last_track = TrackData.last
  end

  #ajax call; used in test.html.erb script 
  def get_database_tracks
  	last_tracks = TrackData.last(10)
  	render :json => last_tracks
  end

  #test controllers are below
  def track
	end

end