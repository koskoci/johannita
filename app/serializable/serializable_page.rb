class SerializablePage < JSONAPI::Serializable::Resource
  type 'pages'
  attribute :slug
  attribute :content
end
