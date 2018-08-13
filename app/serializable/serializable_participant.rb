class SerializableParticipant < JSONAPI::Serializable::Resource
  type 'participants'
  attribute :email do
    @object.user.email
  end

  attribute :name do
    "#{@object.user.last_name} #{@object.user.first_name}"
  end
end
