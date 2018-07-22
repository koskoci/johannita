class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'
  attribute :title
  attribute :content
  attribute :created_at
  attribute :updated_at
  attribute :image_url do
    @url_helpers.url_for(@object.image)
  end
end
