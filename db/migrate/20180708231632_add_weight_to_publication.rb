class AddWeightToPublication < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :weight, :integer
  end
end
