class SerializableCourseEvent < JSONAPI::Serializable::Resource
  type 'course_events'
  attribute :date
  attribute :title
  attribute :created_at
  attribute :updated_at
  belongs_to :course do
    linkage always: true
  end
end
