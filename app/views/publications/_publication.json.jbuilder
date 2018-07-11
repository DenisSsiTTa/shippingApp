json.extract! publication, :id, :title, :width, :length, :height, :description, :price, :created_at, :updated_at
json.url publication_url(publication, format: :json)
