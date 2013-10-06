class AddCoordinatesToTrackData < ActiveRecord::Migration
  def change
    add_column :track_data, :coordinates, :text
  end
end
