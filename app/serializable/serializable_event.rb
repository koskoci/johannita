class SerializableEvent < JSONAPI::Serializable::Resource
  type 'events'
  attribute :title
  attribute :category
  attribute :date
  attribute :created_at
  attribute :updated_at
  attribute :status
  attribute :apply_by
  has_many :participants do
    linkage always: true
  end
end
