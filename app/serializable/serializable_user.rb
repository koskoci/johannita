class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'
  attribute :first_name
  attribute :last_name
  attribute :email
  attribute :pav
  attribute :pav_date
  attribute :driving_licence
  attribute :driving_licence_date
end
