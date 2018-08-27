class AddLatitudeToPublication < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :latitude, :float
    add_column :publications, :longitude, :float
  end
end
