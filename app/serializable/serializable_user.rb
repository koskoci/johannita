class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'
  attribute :first_name
  attribute :last_name
  attribute :email
  attribute :pav_until
  attribute :driving_licence_since
end
