class SerializableCourseEvent < JSONAPI::Serializable::Resource
  type 'course_events'
  attribute :title
  attribute :category do
    @object.course_category.category
  end
  attribute :date
  attribute :created_at
  attribute :updated_at
  attribute :status
  attribute :apply_by
  attribute :can_apply do
    @object.can_apply(@user)
  end
  has_many :participants do
    linkage always: true
  end
end
