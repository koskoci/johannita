class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'
  attribute :title
  attribute :content
  attribute :created_at
  attribute :updated_at
  attribute :thumbnail_url
  attribute :blurb
end
