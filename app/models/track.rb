class Track
	attr_accessor :get_database_tracks, :insert_tracks_into_track_data_table, :filtered_tracks
	
	def initialize
		@client = Soundcloud.new(:client_id => "#{ENV['SOUNDCLOUD_KEY']}")
		@filtered_tracks = []
	end

	#call api to get tracks; used for my home page
	def get_tracks_from_soundcloud
		tracks = @client.get('/tracks', :limit => 6)
		tracks.each do |track|
			user = @client.get('/users/' + track.user_id.to_s)
				if user.city.present? && user.country.present?
					geocoding = Geocoder.search("#{user.city}, #{user.country}").first
					# track.delete_if {geocoding.nil?}
					if geocoding
						lat = geocoding.data["geometry"]["location"]["lat"] ? geocoding.data["geometry"]["location"]["lat"] : ['51']
						lng = geocoding.data["geometry"]["location"]["lng"] ? geocoding.data["geometry"]["location"]["lng"] : ['0.1']
					end
					@filtered_tracks << { track: track, user: user, coordinates: [lat, lng] }
				end
		end
		@filtered_tracks
	end

	#this will be a rake task
	# def insert_tracks_into_track_data_table
 #  	@filtered_tracks.each do |filtered_track|
 #  		if filtered_track[:coordinates].first.nil?
 #  			filtered_tracks.delete(filtered_track)
 #  		else 
 #  			TrackData.create(:track_id => filtered_track[:track].id, 
	#   		:track_name => filtered_track[:track].title, :track_permalink => filtered_track[:track].permalink,
	#    		:user_id => filtered_track[:user].id, :username => filtered_track[:user].username, 
	#    		:user_city => filtered_track[:user].city, :user_country => filtered_track[:user].country, 
	#    		:user_permalink => filtered_track[:user].permalink, :user_avatar_url => filtered_track[:user].avatar_url,
	#    		:lat => filtered_track[:coordinates].first, :lng => filtered_track[:coordinates].last)
 #  		end
 #  	end
	# end

end
