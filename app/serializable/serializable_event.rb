class SerializableEvent < JSONAPI::Serializable::Resource
  type 'events'
  attribute :title
  attribute :category
  attribute :date
  attribute :created_at
  attribute :updated_at
  has_many :participants
end
