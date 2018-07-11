class CreatePublications < ActiveRecord::Migration[5.0]
  def change
    create_table :publications do |t|
      t.string :title
      t.integer :width
      t.integer :length
      t.integer :height
      t.string :equipment
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
