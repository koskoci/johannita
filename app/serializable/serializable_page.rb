class SerializablePage < JSONAPI::Serializable::Resource
  type 'pages'
  attribute :short_name
  attribute :content
  has_many :attachments
end
