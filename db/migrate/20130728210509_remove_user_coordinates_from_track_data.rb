class RemoveUserCoordinatesFromTrackData < ActiveRecord::Migration
  def up
    remove_column :track_data, :user_coordinates
  end

  def down
    add_column :track_data, :user_coordinates, :integer
  end
end
