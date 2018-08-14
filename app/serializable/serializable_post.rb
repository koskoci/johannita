class SerializablePost < JSONAPI::Serializable::Resource
  include Rails.application.routes.url_helpers

  type 'posts'
  attribute :title
  attribute :content
  attribute :created_at
  attribute :updated_at
  attribute :image_url do
    url_for(@object.image) if @object.image.attached?
  end
end
