
namespace :trackdata do 
	desc "import new tracks to the database"

	task :current_environment do 
		puts "You are pulling tracks from Soundcloud"
	end 

	task :import => :environment do 
		client = Soundcloud.new(:client_id => "#{ENV['SOUNDCLOUD_KEY']}")
		tracks = client.get('/tracks', :limit => 200)
		
		tracks.each do |track|
			user = client.get('/users' + track.user_id.to_s)
				if user.city.present? && user.country.present?
					geocoding = Geocoder.search("#{user.city}, #{user.country}").first
				end
				lat = geocoding.data["geometry"]["location"]["lat"]
				lng = geocoding.data["geometry"]["location"]["lng"]

				downloaded_tracks << { track: track, user: user, coordinates: [lat, lng] }
				end
				downloaded_tracks

				downloaded_tracks.select!
					downloaded_tracks[:coordinates].first
				end 

  			TrackData.create(
	  			:track_id => filtered_track[:track].id, 
		  		:track_name => filtered_track[:track].title, 
		  		:track_permalink => filtered_track[:track].permalink,
		   		:user_id => filtered_track[:user].id, 
		   		:username => filtered_track[:user].username, 
		   		:user_city => filtered_track[:user].city, 
		   		:user_country => filtered_track[:user].country, 
		   		:user_permalink => filtered_track[:user].permalink, 
		   		:user_avatar_url => filtered_track[:user].avatar_url,
		   		:lat => filtered_track[:coordinates].first, 
		   		:lng => filtered_track[:coordinates].last
		   		)
			
				end 
			
			end 

	end 
end 	


			

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

# include Yelp::V2::Search::Request
# include Yelp::V2::Business::Request
# namespace :yelpdata do
#   desc "import yelp data to database"

#   task :current_environment do
#       puts "You are running rake task in #{Rails.env} environment"
#     end

#   task :import => :environment do
#    Tag.all.each { |t|
#     Neighborhood.all.each { |n|
#         c = Yelp::Client.new
#         request = Location.new(
#            :term => "#{t.name} bar",
#            :city => 'San Francisco',
#            :neighborhood => n.name,
#            :limit => 20,
#            :consumer_key => ENV['YELP_CONSUMER_KEY'],
#            :consumer_secret => ENV['YELP_CONSUMER_SECRET'],
#            :token => ENV['YELP_TOKEN'],
#            :token_secret => ENV['YELP_TOKEN_SECRET'])

#            response = c.search(request)

#            if response["error"]
#              raise response["error"]["text"]
#            end

#            businesses = response['businesses']
#            puts(businesses)
       
#            businesses.each { |biz|
#               v = Venue.find_by_name(biz['name'])
#               if(v.nil?)
#                 venue = Venue.new(
#                 :name => biz['name'],
#                 :address_1 => biz['location']['address'][0],
#                 :address_2 => biz['location']['cross_streets'],
#                 :city => biz['location']['city'],
#                 :state => biz['location']['state_code'],
#                 :zip => biz['location']['postal_code'],
#                 :img_url => biz['image_url'],
#                 :biz_url => biz['url'],
#                 :YID => biz['id'],
#                 :snippet_text => biz['snippet_text'],
#                 :mobile_url => biz['mobile_url'],
#                 :neighborhood_name => n.name,
#                 :closed => biz['is_closed'],
#                 :rating => biz['rating'])
#                 venue.save!
#                 venue.tags << t
#                 venue.neighborhood = n
#                 venue.save!
#                 puts("Created tag #{t.name} in #{venue.name}")
#               else
#                 unless v.tags.include?(t)
#                   v.tags << t
#                   puts("Added tag #{t.name} in #{v.name}")
#                   puts("#{v.name} has the following tags #{v.tags.inspect}")
#                 end
#               end
#             }
#          }
#        }
#     end
# end
