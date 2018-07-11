class AddCommune2ToPublication < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :commune2, :integer
    add_column :publications, :region2, :integer
    add_column :publications, :address2, :string

    add_reference :publications, :commune2, foreign_key: { to_table: :communes }
    add_reference :publications, :region2, foreign_key: { to_table: :regions }
  end
end
