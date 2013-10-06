require 'pp'

namespace :trackdata do 
	desc "import new tracks to the database"

	task :import => :environment do

		puts "You are pulling tracks from Soundcloud..."
		client = Soundcloud.new(:client_id => "e9e8fbf8ac2f57eb0f54519af9c2f22e")
		tracks = client.get('/tracks', :limit => 50)
		
		downloaded_tracks = []
		tracks.each do |track|
			user = client.get('/users/' + track.user_id.to_s)
				if user.city.present? && user.country.present?
					geocoding = Geocoder.search("#{user.city}, #{user.country}").first
				end
				if geocoding
					lat = geocoding.data["geometry"]["location"]["lat"]
					lng = geocoding.data["geometry"]["location"]["lng"]
					downloaded_tracks << { track: track, user: user, coordinates: [lat, lng] }
				end 
			downloaded_tracks
		end 

		downloaded_tracks.each do |d|
			puts d[:user].username 
			puts d[:track].title
		end 

		downloaded_tracks.each do |downloaded_track|
			if downloaded_track[:coordinates].first.nil?
				downloaded_track.delete(downloaded_track)
			else 
				t = TrackData.find_by_track_id(downloaded_track[:track].id)
				if(t.nil?)
					TrackData.create(
						:track_id => downloaded_track[:track].id, 
			  		:track_name => downloaded_track[:track].title, 
			  		:track_permalink => downloaded_track[:track].permalink,
			   		:user_id => downloaded_track[:user].id, 
			   		:username => downloaded_track[:user].username, 
			   		:user_city => downloaded_track[:user].city, 
			   		:user_country => downloaded_track[:user].country, 
			   		:user_permalink => downloaded_track[:user].permalink, 
			   		:user_avatar_url => downloaded_track[:user].avatar_url,
			   		:lat => downloaded_track[:coordinates].first, 
			   		:lng => downloaded_track[:coordinates].last,
			   		:coordinates => [downloaded_track[:coordinates].first, downloaded_track[:coordinates].last]
			   		)
				end 
			end 
		end 
		
	end 
end 	
