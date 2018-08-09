class SerializableParticipant < JSONAPI::Serializable::Resource
  type 'participants'
  belongs_to :user
end
