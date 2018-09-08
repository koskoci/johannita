class SerializableEventCategory < JSONAPI::Serializable::Resource
  type 'event_categories'
  attribute :category
  attribute :last_date
  attribute :created_at
  attribute :updated_at
end
