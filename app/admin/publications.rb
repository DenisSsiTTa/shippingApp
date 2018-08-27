ActiveAdmin.register Publication do
  index do
    column :id
    column :title
    column :type
    column :category
    column :region
    column :commune
    column :address
    column :region2
    column :commune2
    column :address2
    column :equipments do |publication|
      publication.equipments.collect(&:name).join(', ')
    end
    column :user
  end

  controller do
    def scoped_collection
      Publication.includes(:type, :address, :region, :commune, :address2, :region2, :commune2, :user, :category, :equipments, :shipping_equipments)
    end
  end

  #Filter
  filter :user
  filter :category
  filter :type
  filter :region
  filter :commune
  filter :region2
  filter :commune2
  #filter :title, as: :select -> selecciona los nombres de las publicaciones creadas

  #Form new publication
  permit_params :user, :commune, :region, :commune2, :region2, :category, :type, :title, :width, :length, :height, :description, :price, :address, :address2

end
