class SerializableAttachment < JSONAPI::Serializable::Resource
  include Rails.application.routes.url_helpers

  type do
    @object.name.pluralize
  end
  attribute :id
  attribute :url do
    url_for(@object)
  end
  attribute :content_type
  attribute :byte_size
end
