class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'
  attribute :title
  attribute :content
  attribute :created_at
  attribute :updated_at
  attribute :thumbnail_url
  has_many :images do
    @object.images_attachments
  end
end
