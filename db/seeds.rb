# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



t1 = TrackData.create(:track_id => 13158665, :track_name => 'Munching at Tiannas house', 
	:track_permalink => 'munching-at-tiannas-house', :user_id => 3699101, :username => 'Alex Stevenson', 
	:user_city => 'Berlin', :user_country => 'Germany', :user_coordinates => 52, 
	:user_permalink => 'http://soundcloud.com/alex-stevenson', 
	:user_avatar_url => 'http://i1.sndcdn.com/avatars-000004193858-jnf2pd-large.jpg?5ffe3cd')

