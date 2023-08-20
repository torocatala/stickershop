module Types
    class ProductType < Types::BaseObject
        field :id, ID, null: false
        field :name, String, null: false
        field :price, Float, null: false
        field :description, String, null: false
        field :imageUrl, String, null: false, method: :image_url  # Note the mapping here
    end
end