class SerializableEvent < JSONAPI::Serializable::Resource
  type 'events'
  attribute :title
  attribute :category
  attribute :date
  attribute :created_at
  attribute :updated_at
  attribute :confirmed
  has_many :participants
end
