class SerializableCourse < JSONAPI::Serializable::Resource
  type 'courses'
  attribute :title
  attribute :category do
    @object.course_category.category
  end
  attribute :created_at
  attribute :updated_at
  attribute :status
  attribute :apply_by
  attribute :max_participants
  attribute :can_apply do
    @object.can_apply(@user)
  end
  has_many :participants do
    linkage always: true
  end
end
