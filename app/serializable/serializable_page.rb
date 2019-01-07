class SerializablePage < JSONAPI::Serializable::Resource
  type 'pages'
  attribute :short_name
  attribute :content
end
