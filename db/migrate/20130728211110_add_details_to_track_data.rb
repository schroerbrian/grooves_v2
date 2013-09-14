class AddDetailsToTrackData < ActiveRecord::Migration
  def change
    add_column :track_data, :lat, :float
    add_column :track_data, :lng, :float
  end
end
