class CreateCity < ActiveRecord::Migration
  def change
    create_table :city do |t|
    	t.string :name
    	t.text :image
    	t.text :tracks 
      t.timestamps
    end
  end
end
