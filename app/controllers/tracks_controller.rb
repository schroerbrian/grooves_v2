class TracksController < ApplicationController

  def home
    t = Track.new 
    @filtered_tracks = t.get_tracks_from_soundcloud
  end

  def test
  end

  #ajax call; used in test.html.erb script 
  def get_database_tracks
    binding.pry

    if cookies[:offset].blank?
      cookies[:offset] = 5
      c = cookies[:offset].to_i
      reverse_offset = TrackData.count - offset_number
      requested_tracks = TrackData.limit(5).offset(reverse_offset)
      render :json => requested_tracks 
    else  
      cookies[:offset] = cookies[:offset].to_i + 5
      reverse_offset = TrackData.count - cookies[:offset]
      requested_tracks = TrackData.limit(5).offset(reverse_offset)
      render :json => requested_tracks
    end 
  end

  #test controllers are below
  def track
  end

end


#counter = 0
#tracks = 5
#
# def get_database_tracks
#   
#   most_recent_database_tracks = TrackData.last(5)
#   render :json => most_recent_database_tracks
# end
