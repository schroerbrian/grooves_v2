class CreateTrackData < ActiveRecord::Migration
  def change
    create_table :track_data do |t|
    	t.integer :track_id
    	t.string :track_name
    	t.text :track_permalink
    	t.integer :user_id
    	t.string :username
    	t.string :user_city
    	t.string :user_country 
    	t.integer :user_coordinates
    	t.text :user_permalink
    	t.text :user_avatar_url
      t.timestamps
    end
  end
end
