class Equipment < ApplicationRecord
  has_many :shipping_equipments
  has_many :publications, through: :shipping_equipments
end
