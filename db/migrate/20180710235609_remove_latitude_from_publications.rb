class RemoveLatitudeFromPublications < ActiveRecord::Migration[5.1]
  def change
    remove_column :publications, :latitude, :float
    remove_column :publications, :longitude, :float
  end
end
