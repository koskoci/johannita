class SerializableCourseCategory < JSONAPI::Serializable::Resource
  type 'course_categories'
  attribute :category
  attribute :last_date
  attribute :created_at
  attribute :updated_at
end
