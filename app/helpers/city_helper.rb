module CityHelper 

	def city   
		 	users = [] #holder variable 
			@good_tracks = []
		  geolocation = [] 

			#here's where i call the soundcloud api
			
			client = Soundcloud.new(:client_id => "e9e8fbf8ac2f57eb0f54519af9c2f22e")

			tracks = client.get('/tracks', :limit => 15)
			tracks.each do |track|
				user = client.get('/users/' + track.user_id.to_s)

				if user.city.present? && user.country.present?
					geocoding = Geocoder.search("#{user.city}, #{user.country}").first
					# track.delete_if {geocoding.nil?}
					if geocoding
						lat = geocoding.data["geometry"]["location"]["lat"] ? geocoding.data["geometry"]["location"]["lat"] : ['51']
						lng = geocoding.data["geometry"]["location"]["lng"] ? geocoding.data["geometry"]["location"]["lng"] : ['0.1']
					end

					@good_tracks << { track: track, user: user, coordinates: [lat, lng] }
				end
			end
	end

end