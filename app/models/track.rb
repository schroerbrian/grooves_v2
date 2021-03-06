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

end
