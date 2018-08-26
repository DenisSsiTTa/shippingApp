class RemoveRegion2FromPublications < ActiveRecord::Migration[5.1]
  def change
    remove_column :publications, :region2, :float
    remove_column :publications, :commune2, :float
  end
end
