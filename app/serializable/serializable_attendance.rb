class SerializableAttendance < JSONAPI::Serializable::Resource
  type 'attendances'
  belongs_to :course_event do
    linkage always: true
  end
  belongs_to :participant do
    linkage always: true
  end
end
