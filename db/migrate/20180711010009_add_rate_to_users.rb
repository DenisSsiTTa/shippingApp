class AddRateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :rate, :integer, default: 5
  end
end
